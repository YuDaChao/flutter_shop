import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int currentIndex = 0; // 父类分类索引

  int childCurrentIndex = 0; // 子分类索引

  String parentCategoryId = ''; // 父类分类id

  String subCategoryId = ''; // 当前子分类id

  changeChildCategory(List<BxMallSubDto> categoryList) {
    BxMallSubDto bxMallSubDto = BxMallSubDto(
      mallCategoryId: '',
      mallSubId: '',
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

  changeSubCategoryId(String id) {
    subCategoryId = id;
    notifyListeners();
  }
}
