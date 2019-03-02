import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('http://p0.ifengimg.com/pmop/2018/0625/532B6891B8BA21020CAAE419483E81F07415AC70_size1_w500_h500.jpeg')
                    )
                  ),
                ),
                Container(
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.pinkAccent,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}