import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Nav extends StatefulWidget {

  final List categories;

  Nav({ Key key, this.categories }) : super(key: key);

  @override
  NavState createState() => new NavState();
}

class NavState extends State<Nav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      padding: EdgeInsets.only(top: 11.0, bottom: 5.0),
      width: MediaQuery.of(context).size.width - 16,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: widget.categories.map<Widget>((m) {
          return _navItem(m);
        }).toList(),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
    );
  }

  Widget _navItem(Map m) {
    return Container(
      width: MediaQuery.of(context).size.width / 5 - 4,
      margin: EdgeInsets.only(bottom: 6.0),
      child: InkWell(
        onTap: () {
          print('onTap');
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 6.0),
              child: CircleAvatar(
                radius: 20.0,
                child: CachedNetworkImage(imageUrl: m['image']),
                // backgroundColor: Color(0xFFB88800),
              ),
            ),
            Container(
              child:
              Text(m['mallCategoryName'], style: TextStyle(fontSize: 12.0)),
            )
          ],
        ),
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
  void didUpdateWidget(Nav oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
