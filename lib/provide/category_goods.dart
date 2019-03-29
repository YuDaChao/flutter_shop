import 'package:flutter/material.dart';

import '../model/category_goods.dart';

class CategoryGoodsProvide extends ChangeNotifier {
  List<CategoryGoods> categoryGoodsList = [];

  int currentPage = 1;

  changeCategoryGoodsList(List<CategoryGoods> list) {
    categoryGoodsList = list;
    notifyListeners();
  }

  changeCurrentPage(int current) {
    currentPage = current;
    notifyListeners();
  }
}
