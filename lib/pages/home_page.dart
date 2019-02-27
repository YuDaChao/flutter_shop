import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/api.dart';
import 'swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _data_menus = [
    {'title': '白酒', 'img': ""},
    {'title': '啤酒', 'img': ""},
    {'title': '葡萄酒', 'img': ""},
    {'title': '清酒洋酒', 'img': ""},
    {'title': '保健酒', 'img': ""},
    {'title': '预调酒', 'img': ""},
    {'title': '下酒小菜', 'img': ""},
    {'title': '饮料', 'img': ""},
    {'title': '乳制品', 'img': ""},
    {'title': '休闲零食', 'img': ""}
  ];

  Map<String, dynamic> homePageContent = {};

  List slides = [];
  List categories = [];
  Map advertesPicture;
  Map shopInfo;

  @override
  void initState() {
    super.initState();
     getHomePageContent({'lon': 115.02932, 'lat': 35.76189}).then((res) {
      Map<String, dynamic> jsonData = json.decode(res.toString());
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
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: SwiperView(slides: slides),
            ),
            _menuCard(),
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  advertesPicture == null
                  ? Container() : Image.network(advertesPicture['PICTURE_ADDRESS']),
                  shopInfo == null
                  ? Container() : Image.network(shopInfo['leaderImage']),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _menuItem(Map m) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 6.0, 0, 6.0),
        child: FlatButton(
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 6.0),
                child: CircleAvatar(
                  radius: 20.0,
                  child: Image.network(m['image']),
                  // backgroundColor: Color(0xFFB88800),
                ),
              ),
              Container(
                child: Text(m['mallCategoryName'], style: TextStyle(fontSize: 10.0)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: categories.map<Widget>((m) {
          return _menuItem(m);
        }).toList(),
      ),
    );
  }
}
