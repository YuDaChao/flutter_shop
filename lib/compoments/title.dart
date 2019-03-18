import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String assetImage;

  TitleWidget({Key key, this.title, this.assetImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.0,
      margin: EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 14.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 365.0,
            height: 1.0,
            margin: EdgeInsets.only(top: 10.0),
            color: Color.fromRGBO(203, 203, 203, 1),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Container(
              color: Color.fromRGBO(239, 239, 239, 1.0),
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Container(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      '$assetImage',
                      width: 18.0,
                      height: 18.0,
                    ),
                    Text('$title', style:TextStyle(fontSize: 16.0, color:Color.fromRGBO(132, 134, 137, 1)))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
