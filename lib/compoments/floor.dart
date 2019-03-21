import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/global_config.dart';

class Floor extends StatefulWidget {

  final List floorList;

  Floor({ Key key, this.floorList }) : super(key: key);

  @override
  FloorState createState() => new FloorState();
}

class FloorState extends State<Floor> {
  @override
  Widget build(BuildContext context) {
    if (widget.floorList.isEmpty) {
      return Container();
    }
    int _leftIndex = 0;
    int _rightIndex = 0;
    return Container(
      margin: GlobalConfig.margin,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: widget.floorList
                .sublist(0, 2)
                .map((item) {
                  _leftIndex++;
                  return ClipRRect(
                    borderRadius: _leftIndex == 1 ?
                      BorderRadius.only(topLeft: Radius.circular(8.0))
                    : BorderRadius.only(bottomLeft: Radius.circular(8.0)),
                    child: CachedNetworkImage(imageUrl: item['image']),
                  );
              })
                .toList(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: widget.floorList
                  .sublist(2)
                  .map((item) {
                  _rightIndex++;
                  return ClipRRect(
                    borderRadius: _rightIndex == 1 ?
                    BorderRadius.only(topRight: Radius.circular(8.0))
                        : (_rightIndex % 2 == 0 ?
                            BorderRadius.only(bottomRight: Radius.circular(0.0))
                    :BorderRadius.only(bottomRight: Radius.circular(8.0))),
                    child: CachedNetworkImage(imageUrl: item['image']),
                  );
                })
                  .toList(),
            ),
          ),
        ],
      ));
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
  void didUpdateWidget(Floor oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
