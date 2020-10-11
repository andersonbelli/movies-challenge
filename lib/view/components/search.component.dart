import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _search = false;
  FocusNode _searchFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      // margin: const EdgeInsets.only(top: 8, bottom: 8),
      // padding: const EdgeInsets.symmetric(vertical: 8),
      // color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: TextField(
              onTap: () {
                setState(() {
                  _search = true;
                });
              },
              focusNode: _searchFocus,
              onSubmitted: (value) {
                print(":D" + _searchFocus.hasFocus.toString());
                if (_searchFocus.hasFocus)
                  setState(() {
                    _search = false;
                  });
              },
              decoration: new InputDecoration(
                // icon: Icon(Icons.search),
                fillColor: Colors.grey[200],
                filled: true,
                contentPadding: const EdgeInsets.only(left: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      color: Color.lerp(
                          Colors.lightBlue, Colors.transparent, 0.4),
                      width: 1.5),
                ),
                hintText: "Search a movie",
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: _search ? Colors.lightBlue : Colors.grey,
                  ),
                  splashRadius: 25,
                  onPressed: () {
                    print("SEARCH");
                  },
                ),
              ))
        ],
      ),
    );
  }
}
