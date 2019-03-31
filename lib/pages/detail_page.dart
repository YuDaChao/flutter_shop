import 'package:flutter/material.dart';

class GoodsDetail extends StatefulWidget {
  @override
  GoodsDetailState createState() => new GoodsDetailState();

  final String goodsId;

  GoodsDetail(this.goodsId);

}

class GoodsDetailState extends State<GoodsDetail> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('商品详情'),
      ),
      body: Container(
        child: Text('id: ${widget.goodsId}'),
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
  void didUpdateWidget(GoodsDetail oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
