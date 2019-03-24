import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';

import '../compoments/right_category_item.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  RightCategoryNavState createState() => new RightCategoryNavState();

}

class RightCategoryNavState extends State<RightCategoryNav> {

  ScrollController _controller = new ScrollController();

  double _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) {
        return Container(
          width: 275.0,
          height: 55,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
//              itemExtent: 60, // 列表项高度 / 宽度
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return RightCategoryItem(
                  category: childCategory.childCategoryList[index],
                  activeIndex: index,
                  changeIndex: changeIndex
                );
              }
          ),
          decoration: BoxDecoration(
              color: Color.fromRGBO(248, 248, 248, 1.0)
          ),
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 监听滚动事件
    _controller.addListener(() {
      this.setState(() {
        _scrollOffset = _controller.offset;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(RightCategoryNav oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void changeIndex(int index) {
//    if (_scrollOffset > 0.0) {
//      // 设置ListView滚动到起始位置
//      _controller.animateTo(.0,
//          duration: Duration(milliseconds: 200), curve: Curves.ease);
//    }
  }
}
