import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/global_config.dart';
import 'title.dart';

class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TitleWidget(
            title: '为您推荐',
            assetImage: 'assets/images/recommend.png'
          ),
          _recommendList(),
        ]
      ),
    );
  }


  Widget _recommendItem(int index) {
    double marginRight = index == recommendList.length - 1 ? 0 : 8.0;
    return Container(
      height: 350,
      width: 250,
      margin: EdgeInsets.only(right: marginRight),
      child: InkWell(
        onTap: () {},
        borderRadius: GlobalConfig.borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: GlobalConfig.borderRadius,),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: GlobalConfig.borderTopRadius,
                child: CachedNetworkImage(imageUrl: recommendList[index]['image']),
              ),
              Container(
                width: 250,
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  '${recommendList[index]["goodsName"]}',
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                  ),
                ),
              ),
              Container(
                width: 250,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '¥${recommendList[index]["price"]}',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.0),
                      child: Text('¥${recommendList[index]["mallPrice"]}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black38,
                              decoration: TextDecoration.lineThrough)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendList() {
    return Container(
      height: 350,
      margin: GlobalConfig.margin,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _recommendItem(index);
        },
      ),
    );
  }

}

