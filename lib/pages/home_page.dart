import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../service/api.dart';
import '../config/global_config.dart';
import '../compoments/swiper.dart'; // 轮播
import '../compoments/advertes.dart'; // 广告
import '../compoments/shop_info.dart'; // 店长信息
import '../compoments/activity.dart';
import '../compoments/recommend.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> homePageContent = {};

  List slides = []; // 轮播
  List categories = []; // 分类
  Map advertesPicture;
  Map shopInfo;
  List bottomList = []; // 底部列表

  bool isPerformingRequest = false;
  ScrollController _scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('initState。。。');
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('正在获取数据...');
        this.setState(() {
          isPerformingRequest = true;
        });
        Timer(Duration(seconds: 5), () {
          print('5s后执行');
          this.setState(() {
            isPerformingRequest = false;
          });
        });
      }
    });

    getHomePageContent({'lon': 115.02932, 'lat': 35.76189}).then((jsonData) {
      // JsonCodec codec = new JsonCodec();
      // Map<String, dynamic> jsonData = codec.decode(res.toString());

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

    // getHomeBottomList({'lon': 115.02932, 'lat': 35.76189})
    // .then((resp) {
    //   if (resp.code == '0') {
    //     bottomList = resp.data;
    //   }
    // });
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
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.room,
          color: Colors.white,
        ),
        title: Container(
          height: 35.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.search, color: Colors.grey[300]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '搜索你喜欢的商品',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
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
                    child: _menuCard(),
                  )
                ],
              ),
            ),
            Container(
              margin: GlobalConfig.marginBottom,
              child: Advertes(
                imageUrl: advertesPicture['PICTURE_ADDRESS'],
              ),
            ),
            Container(
              margin: GlobalConfig.marginBottom,
              child: ShopInfo(
                leaderImage: shopInfo['leaderImage'],
                leaderPhone: shopInfo['leaderPhone'],
              ),
            ),
            Container(
              margin: GlobalConfig.marginBottom,
              child: Activity(
                saoma: homePageContent['saoma']['PICTURE_ADDRESS'],
                integralMallPic: homePageContent['integralMallPic']['PICTURE_ADDRESS'],
                newUser: homePageContent['newUser']['PICTURE_ADDRESS'],
              ),
            ),
            Container(
              margin: GlobalConfig.marginBottom,
              child: Recommend(list: homePageContent['recommend'] ??= [],),
            ),
            Container(
              margin: GlobalConfig.marginBottom,
              child:  _floorPic(homePageContent['floor1Pic']),
            ),
            _imageGrid(homePageContent['floor1'] ??= []),
            _floorPic(homePageContent['floor2Pic']),
            _imageGrid(homePageContent['floor2'] ??= []),
            _floorPic(homePageContent['floor3Pic']),
            _imageGrid(homePageContent['floor3'] ??= []),
            _hotArea(),
            _bottomList(),
            _buildProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(Map m) {
    return Container(
      width: MediaQuery.of(context).size.width / 5 - 4,
      margin: EdgeInsets.only(bottom: 6.0),
      child: InkWell(
        onTap: () {
          print('onTap');
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 6.0),
              child: CircleAvatar(
                radius: 20.0,
                child: CachedNetworkImage(imageUrl: m['image']),
                // backgroundColor: Color(0xFFB88800),
              ),
            ),
            Container(
              child:
                  Text(m['mallCategoryName'], style: TextStyle(fontSize: 12.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget _menuCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      padding: EdgeInsets.only(top: 11.0, bottom: 5.0),
      width: MediaQuery.of(context).size.width - 16,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: categories.map<Widget>((m) {
          return _menuItem(m);
        }).toList(),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
    );
  }

  Widget _imageGrid(List list) {
    if (list.isEmpty) {
      return Container();
    }
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: list
                .sublist(0, 2)
                .map((item) => CachedNetworkImage(imageUrl: item['image']))
                .toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: list
                .sublist(2)
                .map((item) => CachedNetworkImage(imageUrl: item['image']))
                .toList(),
          ),
        ),
      ],
    ));
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: SpinKitThreeBounce(
            color: Colors.pink,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _bottomList() {
    return Container(
      color: Colors.white,
      child: Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl:
                          'http://images.baixingliangfan.cn/compressedPic/20190121103035_1212.jpg',
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        '林德曼苹果啤酒250ml林德曼苹果啤酒250ml',
                        style: TextStyle(color: Colors.pink),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text('¥16.00'),
                        Text('¥17.60'),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl:
                          'http://images.baixingliangfan.cn/compressedPic/20190121103035_1212.jpg',
                    ),
                    Text('林德曼苹果啤酒250ml', style: TextStyle(color: Colors.pink)),
                    Row(
                      children: <Widget>[
                        Text('¥16.00'),
                        Text('¥17.60'),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _floorPic(pic) {
    return Container(
      margin: GlobalConfig.margin,
      child: pic == null
          ? Container()
          : CachedNetworkImage(imageUrl: pic['PICTURE_ADDRESS']),
    );
  }

  Widget _hotArea() {
    return Container(
      margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 居中显示
        children: <Widget>[
          Image.asset(
            'assets/images/fire.png',
            width: 16.0,
            height: 16.0,
          ),
          Text(
            '火爆专区',
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
