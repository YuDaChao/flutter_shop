import 'dart:async';
import 'dart:io';


import 'package:dio/dio.dart';

Dio dio = new Dio(new BaseOptions(
  contentType: ContentType.parse("application/x-www-form-urlencoded")
));


class NetUtils {

  static Future get(String url, {Map<String, dynamic> params}) async{
    Response response = await dio.get(url, queryParameters: params);
    return response.data;
  }

  static Future post(String url, {Map<String, dynamic> data}) async{
    Response response = await dio.post(url, data: data);
    return response.data;
  }
}