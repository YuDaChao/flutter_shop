import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import '../service/api.dart';
import '../compoments/search.dart';    // 搜索
import '../compoments/nav.dart';       // 分类导航
import '../compoments/swiper.dart';    // 轮播
import '../compoments/advertes.dart';  // 广告
import '../compoments/shop_info.dart'; // 店长信息
import '../compoments/activity.dart';
import '../compoments/recommend.dart'; // 推荐
import '../compoments/title.dart';
import '../compoments/floor.dart';
import '../compoments/floor_title.dart';
import '../compoments/hot_goods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> homePageContent = {
    'saoma': {},
    'integralMallPic': {},
    'newUser': {},
  };

  List slides = []; // 轮播
  List categories = []; // 分类
  Map advertesPicture = {};
  Map shopInfo = {};
  List hotGoodsList = []; // 底部列表

  int currentPage = 1;

  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();

  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();

  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.room,
          color: Colors.white,
        ),
        title: Search(),
      ),
      body: EasyRefresh(
        key: _easyRefreshKey,
        refreshHeader: BallPulseHeader(key: _headerKey, color: Colors.pink),
        refreshFooter: BallPulseFooter(key: _footerKey, color: Colors.pink,),
        child: ListView(
            children: <Widget>[
              Container(
                height: 338,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: SwiperView(slides: slides),
                    ),
                    Positioned(
                      top: 196,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1.0,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.white54,
                            spreadRadius: 8,
                            blurRadius: 8,
                          )
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 182,
                      child: Nav(categories: categories ??= [],),
                    )
                  ],
                ),
              ),
              Advertes(
                imageUrl: advertesPicture['PICTURE_ADDRESS'],
              ),
              ShopInfo(
                leaderImage: shopInfo['leaderImage'],
                leaderPhone: shopInfo['leaderPhone'],
              ),
              Activity(
                saoma: homePageContent['saoma']['PICTURE_ADDRESS'],
                integralMallPic: homePageContent['integralMallPic']
                ['PICTURE_ADDRESS'],
                newUser: homePageContent['newUser']['PICTURE_ADDRESS'],
              ),
              Recommend(
                recommendList: homePageContent['recommend'] ??= [],
              ),
              FloorTitle(floorPic: homePageContent['floor1Pic'],),
              Floor(floorList: homePageContent['floor1'] ??= [],),
              FloorTitle(floorPic: homePageContent['floor2Pic'],),
              Floor(floorList: homePageContent['floor2'] ??= [],),
              FloorTitle(floorPic: homePageContent['floor3Pic'],),
              Floor(floorList: homePageContent['floor3'] ??= [],),
              TitleWidget(title: '火爆专区', assetImage: 'assets/images/fire.png',),
              HotGoods(hotGoods: hotGoodsList,),
            ]
        ),
        onRefresh: () async {
          getHomeContent({'lon': 115.02932, 'lat': 35.76189});
          this.setState(() {
            currentPage = 1;
          });
          getHotGoodsList(currentPage);
        },
        loadMore: () async {
          this.setState(() {
            currentPage++;
          });
          loadMoreHotGoods(currentPage);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getHomeContent({'lon': 115.02932, 'lat': 35.76189});

    getHotGoodsList(currentPage);

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies。。。。');
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget。。。');
  }

  // 移出renderTree
  @override
  void dispose() {
    super.dispose();
  }

  void loadMoreHotGoods(currentPage) async{
    String resp = await getHomeBottomList({'page': currentPage});
    Map<String, dynamic> jsonData = json.decode(resp.toString());
    if (jsonData['code'] == '0') {
      this.setState(() {
        hotGoodsList.addAll(jsonData['data']);
      });
    }
  }

  void getHomeContent(params) {
    getHomePageContent(params).then((resp) {
      // JsonCodec codec = new JsonCodec();
      Map<String, dynamic> jsonData = json.decode(resp.toString());
      if (jsonData['code'] == '0') {
        this.setState(() {
          homePageContent = jsonData['data'];
          slides = homePageContent['slides'];
          List categoryList = homePageContent['category'];
          int end = categoryList.isEmpty ? 0 : categoryList.length - 1;
          categories = categoryList.sublist(0, end);
          advertesPicture = homePageContent['advertesPicture'];
          shopInfo = homePageContent['shopInfo'];
        });
      }
    });
  }

  void getHotGoodsList(currentPage) {
    getHomeBottomList({'page': currentPage}).then((resp) {
      Map<String, dynamic> jsonData = json.decode(resp.toString());
      if (jsonData['code'] == '0') {
        this.setState(() {
          hotGoodsList= jsonData['data'];
        });
      }
    });
  }
}
