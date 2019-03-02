import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/global_config.dart';

/// 首页广告
class Advertes extends StatelessWidget {
  final String imageUrl;

  Advertes({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: GlobalConfig.borderBottomRadius),
      margin: GlobalConfig.margin,
      child: Column(
        children: <Widget>[
          imageUrl == null
              ? Container()
              : CachedNetworkImage(
                  // placeholder: (context, url) => new CircularProgressIndicator(),
                  imageUrl: imageUrl,
                ),
        ],
      ),
    );
  }
}
