import 'package:flutter/material.dart';

class PreferencesModel extends ChangeNotifier {
  static List<String> _dietTypes = [];
  static List<String> _restrictions = [];
  static int _maxPrepTime = -1; // any


  List<String> get dietTypes => _dietTypes;
  List<String> get restrictions => _restrictions;
  int get maxPrepTime => _maxPrepTime;

  set dietTypes(List<String> dietTypes) {
    _dietTypes = dietTypes;
    notifyListeners();
  }
  set restrictions(List<String> restrictions) {
    _restrictions = restrictions;
    notifyListeners();
  }
  set maxPrepTime(int maxPrepTime) {
    _maxPrepTime = maxPrepTime;
    notifyListeners();
  }
}
