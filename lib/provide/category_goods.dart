import 'package:flutter/material.dart';

import '../model/category_goods.dart';

class CategoryGoodsProvide extends ChangeNotifier {
  List<CategoryGoods> categoryGoodsList = [];

  changeCategoryGoodsList(List<CategoryGoods> list) {
    categoryGoodsList = list;
    notifyListeners();
  }
}
