import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int currentIndex = 0;

  int childCurrentIndex = 0;

  String parentCategoryId = ''; // 父类分类id

  changeChildCategory(List<BxMallSubDto> categoryList) {
    BxMallSubDto bxMallSubDto = BxMallSubDto(
      mallCategoryId: '00',
      mallSubId: '00',
      mallSubName: '全部',
      comments: null,
    );
    childCategoryList = [bxMallSubDto];
    childCategoryList.addAll(categoryList);
    notifyListeners();
  }

  changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  changeChildCurrentIndex(int index) {
    childCurrentIndex = index;
    notifyListeners();
  }

  changeCategoryId(String id) {
    parentCategoryId = id;
    notifyListeners();
  }
}
