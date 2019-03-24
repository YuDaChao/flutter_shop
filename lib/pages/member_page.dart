import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 300),
              child: Provide<Counter>(
                builder: (context, child, counter) => Text('${counter.count}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
