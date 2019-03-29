import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

import '../service/api.dart';

import '../provide/child_category.dart';
import '../provide/category_goods.dart';

import '../model/category.dart';
import '../model/category_goods.dart';

class CategoryItem extends StatefulWidget {

  final Category category;
  final int activeIndex;

  CategoryItem({ Key key, this.category, this.activeIndex }) : super(key: key);

  @override
  CategoryItemState createState() => new CategoryItemState();
}

class CategoryItemState extends State<CategoryItem> {

  @override
  Widget build(BuildContext context) {
    Category category = widget.category;
    int activeIndex = widget.activeIndex;
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) => Container(
        width: 100.0,
        height: 55.0,
        child: InkWell(
          onTap: () {
            Provide.value<ChildCategoryProvide>(context)
              .changeChildCategory(category.bxMallSubDto);

            Provide.value<ChildCategoryProvide>(context)
                .changeCategoryId(category.mallCategoryId);
            int childCurrentIndex = childCategory.childCurrentIndex;
            // 重置子类索引
            if (childCurrentIndex != 0) {
              Provide.value<ChildCategoryProvide>(context)
                .changeChildCurrentIndex(0);
            }
            // 重置页码
            Provide.value<CategoryGoodsProvide>(context)
              .changeCurrentPage(1);
            // 获取分类商品列表
            Map<String, dynamic> data = {
              'categoryId': category.mallCategoryId,
              'categorySubId': '',
              'page':1
            };
            // 修改当前父类索引
            if (childCategory.currentIndex != activeIndex) {
              getCategoryGoods(data);
              Provide.value<ChildCategoryProvide>(context)
                  .changeCurrentIndex(activeIndex);
            }
          },
          child: Stack(
            alignment: FractionalOffset.center,
            children: <Widget>[
              activeIndex == childCategory.currentIndex ? Positioned(
                  left: 0,
                  child: Container(
                    width: 4.0,
                    height: 18.0,
                    color: Colors.pink,
                  )
              ) : Container(),
              Text('${category.mallCategoryName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontSize: activeIndex == childCategory.currentIndex ? 16 : 14,
                    fontWeight: activeIndex == childCategory.currentIndex ? FontWeight.w500 : FontWeight.normal
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: activeIndex == childCategory.currentIndex ? Colors.white : Color.fromRGBO(248, 248, 248, 1.0)
        ),
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
  void didUpdateWidget(CategoryItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
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
        'categoryGoods': jsonData['data'] ??= []
      });
      Provide.value<CategoryGoodsProvide>(context)
          .changeCategoryGoodsList(categoryGoodsModel.categoryGoods);

    }
  }
}
