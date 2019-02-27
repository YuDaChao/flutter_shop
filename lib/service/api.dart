import '../utils/net_utils.dart';
import '../config/service_url.dart';

// 首页
Future getHomePageContent(data) async{
  try {
    return await NetUtils.post(servicePath['homePageContent'], data: data);
  } catch (e) {
    print(e);
  }
}