import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          padding: EdgeInsets.all(5.0),
          color: Colors.white,
          child:
              Text('搜索', style: TextStyle(color: Colors.pink, fontSize: 16.0)),
          onPressed: null,
        ),
      ),
    );
  }
}
