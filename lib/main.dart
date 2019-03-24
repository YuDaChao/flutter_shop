import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import './pages/index_page.dart';

import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods.dart';



void main() {
  var counter = Counter();
  var childCategoryProvide = ChildCategoryProvide();
  var categoryGoodsProvide = CategoryGoodsProvide();
  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategoryProvide>.value(childCategoryProvide))
    ..provide(Provider<CategoryGoodsProvide>.value(categoryGoodsProvide));

  runApp(
    ProviderNode(child: MyApp(), providers: providers)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活',
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Color.fromRGBO(239, 239, 239, 1.0),    //设置页面背景颜色
        primaryIconTheme: IconThemeData(color: Colors.pink)
      ),
      home: IndexPage(),
    );
  }
}
