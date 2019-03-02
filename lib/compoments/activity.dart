import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/global_config.dart';

class Activity extends StatelessWidget {
  final String integralMallPic;
  final String newUser;
  final String saoma;

  Activity({Key key, this.saoma, this.integralMallPic, this.newUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: GlobalConfig.margin,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: GlobalConfig.borderRadius,
              child: integralMallPic != null ? CachedNetworkImage(imageUrl: integralMallPic,) : Container(),
            ),
          ),
          _divider(),
          Expanded(
            child: ClipRRect(
              borderRadius: GlobalConfig.borderRadius,
              child: newUser != null ? CachedNetworkImage(imageUrl: newUser,) : Container(),
            ),
          ),
          _divider(),
          Expanded(
            child: ClipRRect(
              borderRadius: GlobalConfig.borderRadius,
              child: saoma != null ? CachedNetworkImage(imageUrl: saoma,) : Container(),
            ),
          )
        ],
      ),
    );
  }


  Widget _divider() {
    return Container(
      width: 1.0,
      height: 140.0,
      color: Colors.white,
      margin: EdgeInsets.only(left: 4.0, right: 4.0),
    );
  }
}