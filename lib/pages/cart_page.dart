import 'package:flutter/material.dart';

import 'package:provide/provide.dart';

import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              Provide<Counter>(
                builder: (context, child, counter) => Text('${counter.count}', style: TextStyle(
                    fontSize: 30.0
                ),),
              ),
              RaisedButton(
                onPressed: () {
                  Provide.value<Counter>(context).increment();
                },
                child: Text('增加'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
