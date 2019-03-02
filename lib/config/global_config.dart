import 'package:flutter/material.dart';

class GlobalConfig {
  static EdgeInsets margin = EdgeInsets.fromLTRB(8.0, 0, 8.0, 0);
  static EdgeInsets marginBottom = EdgeInsets.only(bottom: 8.0);
  static BorderRadius borderRadius = BorderRadius.all(Radius.circular(8.0));
  static BorderRadius borderBottomRadius = BorderRadius.only(
      bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0));
  static BorderRadius borderTopRadius = BorderRadius.only(
      topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0));
  static BorderRadius borderLeftRadius = BorderRadius.only(
      topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0));
  static BorderRadius borderRightRadius = BorderRadius.only(
      topRight: Radius.circular(8.0), bottomRight: Radius.circular(8.0));
}
