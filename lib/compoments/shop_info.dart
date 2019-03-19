import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/global_config.dart';

class ShopInfo extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  ShopInfo({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: GlobalConfig.margin,
      child: InkWell(
        onTap: _handleOnTap,
        borderRadius: GlobalConfig.borderRadius,
        child: ClipRRect( // 给图片添加圆角
          borderRadius: GlobalConfig.borderRadius,
          child: leaderImage != null
              ? CachedNetworkImage(imageUrl: leaderImage,)
              : Container(),
        ),
      ),
    );
  }

  void _handleOnTap() async{
    String url = 'tel:$leaderPhone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Conld not launch $url');
    }
  }

}
