import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperView extends StatefulWidget {
  final slides;

  @override
  _SwiperState createState() => _SwiperState();


  SwiperView({Key key, @required this.slides}) :super(key: key);
}

class _SwiperState extends State<SwiperView> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _swiperWidget(),
    );
  }

  Widget _swiperWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Swiper(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          String image = widget.slides.isEmpty ? '' : widget.slides[index]['image'];
          return (image == '' ? Container() : Image.network('$image', fit: BoxFit.fill,));
        },
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          builder: DotSwiperPaginationBuilder(
            color: Colors.black45,
            activeColor: Colors.white
          )
        ),
        controller: SwiperController(),
        autoplay: true,
        // viewportFraction: 0.8,
        // scale: 0.9,
      ),
    );
  }
}