import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import './pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活',
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Color.fromRGBO(245, 245, 245, 1.0),    //设置页面背景颜色
        primaryIconTheme: IconThemeData(color: Colors.pink)
      ),
      home: IndexPage(),
    );
  }
}