import 'package:flutter/material.dart';
import '../core/constant/data.dart';

class IconsController extends ChangeNotifier {
  int iconSelected = 29;
  String iconName = icons[29];

  changeIcon(int index) {
    iconSelected = index;
    iconName = icons[index];
    notifyListeners();
  }
}
