import 'package:flutter/material.dart';

class MainScreenController extends ChangeNotifier {
  PageController pageController = PageController();
  int currentIndex = 0;

  changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}
