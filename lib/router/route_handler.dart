import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../pages/detail_page.dart';


Handler goodsDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return GoodsDetail(params['id'][0]);
  }
);
