import 'package:flutter/material.dart';

import '../model/category.dart';

import './category_item.dart';

class LeftCategoryNav extends StatefulWidget {

  List<Category> categoryList;

  LeftCategoryNav({ Key key, this.categoryList}) : super(key: key);

  @override
  LeftCategoryNavState createState() => new LeftCategoryNavState();
}

class LeftCategoryNavState extends State<LeftCategoryNav> {
  @override
  Widget build(BuildContext context) {
    List<Category> categoryList = widget.categoryList;
    return Container(
      width: 110.0,
      child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryItem(category: categoryList[index], activeIndex: index);
          }
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(248, 248, 248, 1.0)
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(LeftCategoryNav oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
