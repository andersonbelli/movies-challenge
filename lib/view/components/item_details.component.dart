import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/model/movie_details.model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ItemDetail extends StatefulWidget {
  final MovieDetailsModel item;

  final PanelController _panelController;
  final AnimationController _animationController;

  const ItemDetail(this._panelController, this._animationController,
      {Key key, this.item})
      : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    print("\n\n\nAGUIII");
    print(widget.item.tagline.toString());

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
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                itemCount: widget.item.genres.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return Container(
                    height: 5,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  );
                }),
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
                        color: Colors.lightBlue,
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
}
