import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/global_config.dart';

class FloorTitle extends StatelessWidget {

  final Map<String, dynamic> floorPic;

  FloorTitle({ Key key, this.floorPic }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: GlobalConfig.margin,
      child: floorPic == null
          ? Container()
          : CachedNetworkImage(imageUrl: floorPic['PICTURE_ADDRESS']),
    );
  }
}
