import 'dart:async'; // Example: In Dart 2.1, the dart:core library re-exports Future and Stream from dart:async.
import '../utils/net_utils.dart';
import '../config/service_url.dart';

// 首页
Future getHomePageContent(data) async{
  try {
    return await NetUtils.post(ServicePath.homePageContent, data: data);
  } catch (e) {
    print('请求接口出错: $e');
    return {};
  }
}

// 首页列表
Future getHomeBottomList(data) async{
  try {
    return await NetUtils.post(ServicePath.homePageBelowContent, data: data);
  } catch (e) {
    print('请求接口出错: $e');
    return {};
  }
}

// 商品分类
Future getGoodsCategory() async{
  try {
    return await NetUtils.post(ServicePath.getCategory);
  } catch (e) {
    print('请求接口出错: $e');
    return {};
  }
}
