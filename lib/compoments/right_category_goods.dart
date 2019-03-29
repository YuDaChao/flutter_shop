import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

import 'dart:convert';

import '../service/api.dart';


import '../provide/category_goods.dart';
import '../provide/child_category.dart';
import '../model/category_goods.dart';

class RightCategoryGoods extends StatefulWidget {
  @override
  RightCategoryGoodsState createState() => new RightCategoryGoodsState();
}

class RightCategoryGoodsState extends State<RightCategoryGoods> {


  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();

  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
//    Widget _footer = ClassicsFooter(
//      key: _footerKey,
//      loadHeight: 50.0,
//      loadText: "pushToLoad",
//      loadReadyText: "releaseToLoad",
//      loadingText: "loading",
//      loadedText: "loaded",
//      noMoreText: "noMore",
//      bgColor: Colors.transparent,
//      textColor: Colors.pink,
//    );
    return Provide<CategoryGoodsProvide>(
      builder: (context, child, categoryGoodsProvide) => Container(
        width: 267,
        height: 563.0,
        margin: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
        color: Colors.white,
        child: EasyRefresh(
          key: _easyRefreshKey,
          refreshFooter: BallPulseFooter(key: _footerKey, color: Colors.pink,),
          child: ListView.builder(
            itemCount: categoryGoodsProvide.categoryGoodsList.length,
            itemBuilder: (context, index) {
              print('${categoryGoodsProvide.categoryGoodsList}');
              return goodsItems(categoryGoodsProvide.categoryGoodsList[index]);
            }
          ),
          loadMore: () async{
            loadMoreCategoryGoods();
          },
        ),
      )
    );
  }

  Widget goodsItems(CategoryGoods item) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(right: 8.0),
            child: CachedNetworkImage(imageUrl: item.image),
          ),
          Expanded(
            child: Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(0, 10.0, 8.0, 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 6.0),
                    child: Text('${item.goodsName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1.0),
                        fontSize: 14.0
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('¥', style: TextStyle(color: Colors.pink),),
                        Container(
                          margin: EdgeInsets.only(left: 2.0),
                          child: Text('${item.presentPrice}',
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 18.0
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6.0),
                          child: Text('¥${item.oriPrice}',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14.0,
                              decoration: TextDecoration.lineThrough
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color.fromRGBO(239, 239, 239, 1.0))
                )
              ),
            )
          )
        ],
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
  void didUpdateWidget(RightCategoryGoods oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void loadMoreCategoryGoods() {
    // 修改页码
    int currentPage = Provide.value<CategoryGoodsProvide>(context).currentPage;
    Provide.value<CategoryGoodsProvide>(context).changeCurrentPage(currentPage++);
    // 获取参数
    Map<String, dynamic> data = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).parentCategoryId,
      'categorySubId': Provide.value<ChildCategoryProvide>(context).subCategoryId,
      'page': currentPage
    };
    print('------ $data');
    getCategoryGoods(data);
  }

  void getCategoryGoods(data) async{
    String response = await getCategoryGoodsList(data);
    Map<String, dynamic> jsonData = json.decode(response.toString());
    if(jsonData['code'] == '0' ) {
      CategoryGoodsModel categoryGoodsModel = CategoryGoodsModel.fromJson({
        'categoryGoods': jsonData['data'] ??= []
      });
      if (categoryGoodsModel.categoryGoods.isEmpty) {
        Fluttertoast.showToast(msg: '没有更多数据');
      } else {
        Provide.value<CategoryGoodsProvide>(context)
            .changeCategoryGoodsList(categoryGoodsModel.categoryGoods);
      }
    } else {
      Fluttertoast.showToast(msg: '数据加载失败');
    }
  }
}
