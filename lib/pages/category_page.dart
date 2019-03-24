import 'package:flutter/material.dart';

import 'dart:convert';
import '../model/category.dart';
import '../service/api.dart';

import '../compoments/left_category_nav.dart';
import '../compoments/right_category_nav.dart';
import '../compoments/right_category_goods.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Category> categoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(categoryList: categoryList,),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                RightCategoryGoods()
              ],
            )
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategory();
  }

  void getCategory() {
    getGoodsCategory().then((resp) {
      Map<String, dynamic> jsonData = json.decode(resp.toString());
      if (jsonData['code'] == '0') {
        Map<String, dynamic> m = { 'categoryList': jsonData['data'] };
        CategoryModel categoryModel = CategoryModel.fromJson(m);
        this.setState(() {
          categoryList= categoryModel.categoryList;
        });
      }
    });
  }

}
