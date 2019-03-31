import 'package:flutter/material.dart';

import 'goods_item.dart';

class HotGoods extends StatefulWidget {

  final List hotGoods;

  HotGoods({ Key key, this.hotGoods }) : super(key: key);

  @override
  HotGoodsState createState() => new HotGoodsState();
}

class HotGoodsState extends State<HotGoods> {
  @override
  Widget build(BuildContext context) {
    List goods = widget.hotGoods;
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.start,
        children: goods.map((item) => GoodsItem(goodsItem: item)).toList(),
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
  void didUpdateWidget(HotGoods oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
