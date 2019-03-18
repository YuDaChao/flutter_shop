import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static final navigationBarColor = Colors.pink;

  final List<BottomNavigationBarItem> navigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: navigationBarColor,
        ),
        title: Text(
          '首页',
          style: TextStyle(color: navigationBarColor),
        )),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.category,
          color: navigationBarColor,
        ),
        title: Text(
          '分类',
          style: TextStyle(color: navigationBarColor),
        )),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart,
          color: navigationBarColor,
        ),
        title: Text(
          '购物车',
          style: TextStyle(color: navigationBarColor),
        )),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: navigationBarColor,
        ),
        title: Text(
          '会员中心',
          style: TextStyle(color: navigationBarColor),
        ))
  ];

  final List<Widget> tabBodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        body: IndexedStack(
          index: _currentIndex,
          children: tabBodies,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: navigationBarItems,
          type: BottomNavigationBarType.fixed, // 0~3默认采用fixed模式, 4个采用shifting模式
          currentIndex: _currentIndex,
          onTap: handleOnTap,
        ));
  }

  void handleOnTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  void handleOnPress() {
    print('button press');
  }
}
