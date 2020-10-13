import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/database/dao/favorites.database.dart';
import 'package:movies_challenge/model/movie_details.model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ItemDetail extends StatefulWidget {
  final MovieDetailsModel item;

  final bool isFavorite;
  final bool isImageValid;

  final PanelController _panelController;
  final AnimationController _animationController;

  const ItemDetail(this._panelController, this._animationController,
      {Key key, this.item, this.isFavorite = false, this.isImageValid = false})
      : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail>
    with SingleTickerProviderStateMixin {
  final FavoritesDatabase _favoritesDatabase = new FavoritesDatabase();
  IconData _favIcon = Icons.favorite_border;

  @override
  void initState() {
    widget.isFavorite
        ? _favIcon = Icons.favorite
        : _favIcon = Icons.favorite_border;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5)
                  .animate(widget._animationController),
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 45,
                  color: Colors.white38,
                ),
                onPressed: () {
                  if (widget._panelController.isPanelOpen) {
                    widget._panelController.close();
                    widget._animationController.forward();
                  } else {
                    widget._panelController.open();
                    widget._animationController.reset();
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child:
                        // Text(":D"),
                        ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            itemCount: widget.item.genres.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) {
                              return Container(
                                height: 5,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                margin: const EdgeInsets.only(right: 5),
                                child: Center(
                                    child: Text(
                                  widget.item.genres[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )),
                                decoration: BoxDecoration(
                                    // shape: BoxShape.rectangle,
                                    color: Colors.black26,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              );
                            }),
                  ),
                ),
                Expanded(
                  child: Material(
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      splashColor: Colors.red,
                      splashRadius: 18,
                      icon: Icon(
                        this._favIcon,
                        size: 45,
                        color: Color.fromRGBO(242, 99, 112, 1),
                      ),
                      onPressed: () {
                        if (this._favIcon != Icons.favorite) {
                          _favoritesDatabase
                              .save(
                                  widget.item.id,
                                  widget.item.title,
                                  widget.item.voteAverage.toString(),
                                  widget.isImageValid
                                      ? widget.item.posterUrl
                                      : Constants.PLACE_HOLDER_IMAGE)
                              .then((value) {
                            print("\n Saved! ID: " + value.toString());
                            if (value.runtimeType.toString() == "int") {
                              setState(() {
                                this._favIcon = Icons.favorite;
                              });
                            }
                          });
                        } else {
                          print("Remove favorite");

                          _showDialog(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Flex(direction: Axis.horizontal, children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    widget.item.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      widget.item.voteAverage.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                color: Colors.black87,
                                blurRadius: 5,
                                offset: Offset(2, 2))
                          ],
                          fontSize: 24),
                    )),
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(242, 99, 112, 1),
                        color: Colors.green[400],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400],
                              spreadRadius: 2,
                              blurRadius: 6),
                        ]),
                  ),
                )
              ]),
            ),
          ),
          Expanded(
              flex: widget.item.tagline != "" ? 3 : 2,
              child: Container(
                width: double.maxFinite,
                child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black87),
                        children: [
                          TextSpan(children: [
                            TextSpan(text: "Original title: "),
                            TextSpan(
                                text: widget.item.originalTitle,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                          TextSpan(
                            text: "\n",
                            style: TextStyle(color: Colors.black87),
                            children: [
                              TextSpan(text: "Release date: "),
                              TextSpan(
                                  text: DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(widget.item.releaseDate)),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          TextSpan(
                            text: "\n",
                            style: TextStyle(color: Colors.black87),
                            children: [
                              TextSpan(text: "Runtime: "),
                              TextSpan(
                                  text: widget.item.runtime.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          widget.item.tagline != ""
                              ? TextSpan(
                                  text: "\n\n",
                                  children: [
                                    TextSpan(text: "Tagline: "),
                                    TextSpan(
                                      text: "\"${widget.item.tagline}\"",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                )
                              : TextSpan(),
                        ])),
              )),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "Overview\n\n",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: widget.item.overview,
                                style: TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                    )),
              )),
        ],
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Remove from favorites?", textAlign: TextAlign.center),
            content: Text(
                "Would you like to remove this movies from your favorites?"),
            actions: [
              RaisedButton(
                  color: Colors.green[400],
                  textColor: Colors.white,
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _favoritesDatabase.delete(widget.item.id).then((value) {
                      print("\n Removed! Response: " + value.toString());
                      setState(() {
                        this._favIcon = Icons.favorite_border;
                      });
                      Navigator.of(context).pop();
                    });
                  }),
            ],
          );
        });
  }
}
