import 'package:flutter/material.dart';

class Navbrcontroller extends ChangeNotifier {
  int _index = 0;
  int get favourites => _index;

  void changeindex(int i) {
    _index = i;
    notifyListeners();
  }
}
