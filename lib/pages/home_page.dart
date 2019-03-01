import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../service/api.dart';
import '../compoments/swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, dynamic> homePageContent = {};

  List slides = []; // 轮播
  List categories = []; // 分类
  Map advertesPicture;
  Map shopInfo;
  List bottomList = []; // 底部列表

  bool isPerformingRequest = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('正在获取数据...');
        this.setState(() {
          isPerformingRequest = true;
        });
        Timer(Duration(seconds: 5), (){
          print('5s后执行');
          this.setState(() {
            isPerformingRequest = false;
          });
        });
      }
    });

    getHomePageContent({'lon': 115.02932, 'lat': 35.76189})
    .then((jsonData) {
    // JsonCodec codec = new JsonCodec();
    // Map<String, dynamic> jsonData = codec.decode(res.toString());

      if (jsonData['code'] == '0') {
        this.setState(() {
          homePageContent = jsonData['data'];
          slides = homePageContent['slides'];
          List categoryList = homePageContent['category'];
          int end =categoryList.isEmpty ? 0 : categoryList.length - 1;
          categories = categoryList.sublist(0, end);
          advertesPicture = homePageContent['advertesPicture'];
          shopInfo = homePageContent['shopInfo'];
        });
      }
    });

    getHomeBottomList({'lon': 115.02932, 'lat': 35.76189})
    .then((resp) {
      if (resp.code == '0') {
        bottomList = resp.data;
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {},
          child: Icon(Icons.room, color: Colors.white),
        ),
        title: Container(
          height: 35.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(6.0)
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.search, color: Colors.grey[300]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('搜索你喜欢的商品', style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[300],
              ),),
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
              height: 200,
              child: SwiperView(slides: slides),
            ),
            _menuCard(),
            Container(
              margin: EdgeInsets.only(bottom: 6.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  advertesPicture == null
                  ? Container()
                  : CachedNetworkImage(
                    // placeholder: (context, url) => new CircularProgressIndicator(),
                    imageUrl: advertesPicture['PICTURE_ADDRESS'],
                  ),
                  shopInfo == null
                  ? Container()
                  : CachedNetworkImage(
                    // placeholder: (context, url) => new CircularProgressIndicator(),
                    imageUrl: shopInfo['leaderImage'],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 4.0),
              margin: EdgeInsets.only(bottom: 6.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: homePageContent['saoma'] == null ? Container() :CachedNetworkImage(imageUrl: homePageContent['saoma']['PICTURE_ADDRESS']),
                  ),
                   Expanded(
                    flex: 1,
                    child: homePageContent['integralMallPic'] == null ? Container() :CachedNetworkImage(imageUrl: homePageContent['integralMallPic']['PICTURE_ADDRESS']),
                  ),
                  Expanded(
                    flex: 1,
                    child: homePageContent['newUser'] == null ? Container() :CachedNetworkImage(imageUrl: homePageContent['newUser']['PICTURE_ADDRESS']),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(8.0, 4.0, 0, 4.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide( color: Colors.grey[100]))
                    ),
                    child: Text('商品推荐', style:TextStyle(color: Colors.pink, fontSize: 14.0)),
                  ),
                  _recommendListWidget(homePageContent['recommend'] ??= []),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: homePageContent['floor1Pic'] == null ? Container() :CachedNetworkImage(imageUrl: homePageContent['floor1Pic']['PICTURE_ADDRESS']),
            ),
            _imageGrid(homePageContent['floor1'] ??= []),
            Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: homePageContent['floor2Pic'] == null ? Container() :CachedNetworkImage(imageUrl: homePageContent['floor2Pic']['PICTURE_ADDRESS']),
            ),
            _imageGrid(homePageContent['floor2'] ??= []),
            Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: homePageContent['floor3Pic'] == null ? Container() :CachedNetworkImage(imageUrl: homePageContent['floor3Pic']['PICTURE_ADDRESS']),
            ),
            _imageGrid(homePageContent['floor3'] ??= []),
            Container(
              margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 居中显示
                children: <Widget>[
                  Image.asset('assets/images/fire.png', width: 16.0, height: 16.0,),
                  Text('火爆专区', style: TextStyle(fontSize: 12.0),)
                ],
              ),
            ),
            _bottomList(),
            _buildProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(Map m) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      margin: EdgeInsets.only(bottom: 6.0),
      child: InkWell(
        onTap: () {print('onTap');},
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
              child: Text(m['mallCategoryName'], style: TextStyle(fontSize: 10.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget _menuCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
      padding: EdgeInsets.only(top: 11.0, bottom: 5.0),
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: categories.map<Widget>((m) {
          return _menuItem(m);
        }).toList(),
      ),
    );
  }

  // Widget _gridView() {
  //   return Container(
  //     height: 150.0,
  //     color: Colors.white,
  //     margin: EdgeInsets.only(bottom: 6.0),
  //     child: GridView.count( // 使用GridView 必须指定高度
  //       crossAxisCount: 5, // 每行有几个元素
  //       padding: EdgeInsets.only(top: 6.0),
  //       children: categories.map<Widget>((m) {
  //         return _menuItem(m);
  //       }).toList(),
  //     ),
  //   );
  // }

  Widget _recommendItem(Map item, int index) {
    Widget w = index % 2 == 0
    ? Expanded(
      child: Column(
        children: <Widget>[
          CachedNetworkImage(imageUrl: item['image']),
          Text('¥${item["price"]}', style: TextStyle(fontSize: 14.0),),
          Text(
            '¥${item["mallPrice"]}',
            style: TextStyle(fontSize: 12.0, color: Colors.black38, decoration: TextDecoration.lineThrough))
        ],
      ),
    )
    : Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey[100]), right: BorderSide(color: Colors.grey[100]))
        ),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(imageUrl: item['image']),
            Text('¥${item["price"]}', style: TextStyle(fontSize: 14.0),),
            Text(
              '¥${item["mallPrice"]}',
              style: TextStyle(fontSize: 12.0, color: Colors.black38, decoration: TextDecoration.lineThrough))
          ],
        ),
      ),
    );
    return w;
  }

  Widget _recommendListWidget(List list) {
    int index = 0;
    return Container(
      child: Row(
        children: list.map<Widget>((m){
          index = index + 1;
          return _recommendItem(m, index);
        }).toList(),
      )
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
              children: list.sublist(0,2).map((item) => CachedNetworkImage(imageUrl: item['image'])).toList(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: list.sublist(2).map((item) => CachedNetworkImage(imageUrl: item['image'])).toList(),
            ),
          ),
        ],
      )
    );
  }


  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: SpinKitThreeBounce(color: Colors.pink, size: 20,),
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
                      imageUrl: 'http://images.baixingliangfan.cn/compressedPic/20190121103035_1212.jpg',
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text('林德曼苹果啤酒250ml林德曼苹果啤酒250ml',
                        style:TextStyle(color: Colors.pink),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
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
                      imageUrl: 'http://images.baixingliangfan.cn/compressedPic/20190121103035_1212.jpg',
                    ),
                    Text('林德曼苹果啤酒250ml', style:TextStyle(color: Colors.pink)),
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

  // Widget _demo() {
  //   return Container(
  //     height: 600,
  //     child: new StaggeredGridView.countBuilder(
  //       crossAxisCount: 3,
  //       itemCount: 5,
  //       itemBuilder: (BuildContext context, int index) => new Container(
  //           color: Colors.green,
  //           child: new Center(
  //             child: new CircleAvatar(
  //               backgroundColor: Colors.white,
  //               child: new Text('$index'),
  //             ),
  //           )),
  //       staggeredTileBuilder: (int index) =>
  //           new StaggeredTile.count(2, index % 3 == 0 ? 2 : 1),
  //       mainAxisSpacing: 4.0,
  //       crossAxisSpacing: 4.0,
  //     ),
  //   );
  // }

}
