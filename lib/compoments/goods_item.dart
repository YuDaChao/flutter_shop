import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/global_config.dart';

class GoodsItem extends StatefulWidget {

  final Map goodsItem;

  GoodsItem({ Key key, this.goodsItem }) : super(key: key);

  @override
  GoodsItemState createState() => new GoodsItemState();
}

class GoodsItemState extends State<GoodsItem> {
  @override
  Widget build(BuildContext context) {
    Map item = widget.goodsItem;
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 12.0,
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: GlobalConfig.borderTopRadius,
            child: CachedNetworkImage(imageUrl: item['image']),
          ),
          Container(
            margin: EdgeInsets.only(top: 6.0, bottom: 10.0),
            child: Text(item['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '¥${item["mallPrice"]}',
                  style: TextStyle(fontSize: 18.0, color: Colors.pink),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6.0),
                  child: Text('¥${item["price"]}',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough,
                      )),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: GlobalConfig.borderRadius
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
  void didUpdateWidget(GoodsItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
