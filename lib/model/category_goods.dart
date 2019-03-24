
class CategoryGoodsModel {
  List<CategoryGoods> categoryGoods;

  CategoryGoodsModel({this.categoryGoods});

  CategoryGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['categoryGoods'] != null) {
      categoryGoods = new List<CategoryGoods>();
      json['categoryGoods'].forEach((v) {
        categoryGoods.add(new CategoryGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryGoods != null) {
      data['categoryGoods'] =
          this.categoryGoods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryGoods {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  CategoryGoods(
      {this.image,
        this.oriPrice,
        this.presentPrice,
        this.goodsName,
        this.goodsId});

  CategoryGoods.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

