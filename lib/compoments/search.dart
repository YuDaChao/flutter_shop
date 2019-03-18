import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => new SearchState();
}

class SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.search, color: Colors.grey[300]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              '搜索你喜欢的商品',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[300],
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Search oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
