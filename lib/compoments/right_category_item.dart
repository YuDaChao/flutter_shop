import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

import '../service/api.dart';

import '../provide/child_category.dart';
import '../provide/category_goods.dart';

import '../model/category.dart';
import '../model/category_goods.dart';

class RightCategoryItem extends StatefulWidget {

  final BxMallSubDto category;
  final activeIndex;

  final Function changeIndex;

  RightCategoryItem({ Key key, this.category, this.activeIndex, this.changeIndex }) : super(key: key);

  @override
  RightCategoryItemState createState() => new RightCategoryItemState();
}

class RightCategoryItemState extends State<RightCategoryItem> {
  @override
  Widget build(BuildContext context) {
    BxMallSubDto category = widget.category;
    int activeIndex = widget.activeIndex;
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) => Container(
        height: 55.0,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: InkWell(
          onTap: () {
            if (childCategory.childCurrentIndex != activeIndex) {
              Map<String, dynamic> data = {
                'categoryId': childCategory.parentCategoryId,
                'categorySubId': category.mallSubId,
                'page':1
              };
              // 获取数据
              getCategoryGoods(data);
              // 改变当前子类索引
              Provide.value<ChildCategoryProvide>(context)
                .changeChildCurrentIndex(activeIndex);
              // 设置子类id
              Provide.value<ChildCategoryProvide>(context)
                .changeSubCategoryId(category.mallSubId);
              // 重置页码
              Provide.value<CategoryGoodsProvide>(context)
                .changeCurrentPage(1);
              widget.changeIndex(activeIndex);
            }
          },
          child: Stack(
            alignment: FractionalOffset.center,
            children: <Widget>[
              Text('${category.mallSubName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: childCategory.childCurrentIndex == widget.activeIndex
                      ? Colors.pink : Color.fromRGBO(51, 51, 51, 1),
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(248, 248, 248, 1.0)
        ),
      )
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
  void didUpdateWidget(RightCategoryItem oldWidget) {
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
    if(jsonData['code'] == '0' ) {
      CategoryGoodsModel categoryGoodsModel = CategoryGoodsModel.fromJson({
        'categoryGoods': jsonData['data'] ??= []
      });
      Provide.value<CategoryGoodsProvide>(context)
          .changeCategoryGoodsList(categoryGoodsModel.categoryGoods);

    }
  }
}
