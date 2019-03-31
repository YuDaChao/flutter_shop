import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './route_handler.dart';

class Routes {
  static String goodsDetailPath = '/detail/:id';

  static void configureRoutes(Router router) {
    // 404 路由
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        print('PAGE NOT FOUND');
      }
    );

    router.define(goodsDetailPath, handler: goodsDetailHandler, transitionType: TransitionType.inFromRight);
  }

}
