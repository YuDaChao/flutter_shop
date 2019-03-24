import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

import '../service/api.dart';

import '../provide/child_category.dart';
import '../provide/category_goods.dart';

import '../model/category.dart';
import '../model/category_goods.dart';

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
      width: 100.0,
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
    List<Category> categoryList = widget.categoryList;
    // 初始化右边菜单
    Provide.value<ChildCategoryProvide>(context)
        .changeChildCategory(categoryList[0].bxMallSubDto);
    // 获取分类商品列表
    String categoryId = categoryList[0].mallCategoryId;
    Provide.value<ChildCategoryProvide>(context)
        .changeCategoryId(categoryId);
    Map<String, dynamic> data = {
      'categoryId': categoryId,
      'categorySubId': '',
      'page':1
    };
    getCategoryGoods(data);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getCategoryGoods(data) async{
    String response = await getCategoryGoodsList(data);
    Map<String, dynamic> jsonData = json.decode(response.toString());
    if(jsonData['code'] == '0') {
      CategoryGoodsModel categoryGoodsModel = CategoryGoodsModel.fromJson({
        'categoryGoods': jsonData['data']
      });
      Provide.value<CategoryGoodsProvide>(context)
          .changeCategoryGoodsList(categoryGoodsModel.categoryGoods);

    }
  }
}
