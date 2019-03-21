import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryItem extends StatefulWidget {

  final Category category;
  final int activeIndex;

  CategoryItem({ Key key, this.category, this.activeIndex }) : super(key: key);

  @override
  CategoryItemState createState() => new CategoryItemState();
}

class CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    Category category = widget.category;
    int activeIndex = widget.activeIndex;
    return Container(
      width: 110.0,
      height: 55.0,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            activeIndex == 2 ? Positioned(
              left: 0,
              child: Container(
                width: 4.0,
                height: 18.0,
                color: Colors.pink,
              )
            ) : Container(),
            Text('${category.mallCategoryName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: activeIndex == 2 ? 18 : 16,
                  fontWeight: activeIndex == 2 ? FontWeight.w500 : FontWeight.normal
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: activeIndex == 2 ? Colors.white : Color.fromRGBO(248, 248, 248, 1.0)
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
  void didUpdateWidget(CategoryItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
