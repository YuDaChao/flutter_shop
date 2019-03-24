import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int count = 1;

  void increment() {
    count++;
    notifyListeners();
  }
}
