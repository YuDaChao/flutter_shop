import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/global_config.dart';

class Recommend extends StatelessWidget {
  final List list;

  Recommend({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
      child: Column(
        children: <Widget>[
          _recommendTitle(),
          Container(
            padding: EdgeInsets.only(bottom: 4.0),
            margin: GlobalConfig.margin,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: list.map<Widget>((m) {
                      index = index + 1;
                      return _recommendItem(m, index);
                  }).toList(),
                ))
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: GlobalConfig.borderBottomRadius
            ),
          ),
        ]
      ),
    );
  }


  Widget _recommendTitle() {
    return Container(
      height: 21.0,
      margin: EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 14.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 365.0,
            height: 1.0,
            margin: EdgeInsets.only(top: 10.0),
            color: Color.fromRGBO(203, 203, 203, 1),
          ),
          Positioned(
            left: 140.0,
            child: Container(
              color: Color.fromRGBO(245, 245, 245, 1.0),
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Text('为您推荐', style:TextStyle(fontSize: 14.0, color:Color.fromRGBO(132, 134, 137, 1))),
            ),
          )
        ],
      ),
    );
  }

  Widget _recommendItem(Map item, int index) {
    Widget w = index % 2 == 0
        ? Expanded(
            child: Column(
              children: <Widget>[
                CachedNetworkImage(imageUrl: item['image']),
                Text(
                  '¥${item["price"]}',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text('¥${item["mallPrice"]}',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black38,
                        decoration: TextDecoration.lineThrough))
              ],
            ),
          )
        : Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.grey[100]),
                      right: BorderSide(color: Colors.grey[100]))),
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(imageUrl: item['image']),
                  Text(
                    '¥${item["price"]}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text('¥${item["mallPrice"]}',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough))
                ],
              ),
            ),
          );
    return w;
  }

}

