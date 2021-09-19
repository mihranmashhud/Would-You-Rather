// ignore_for_file: file_names, prefer_final_fields

import 'package:flutter/material.dart';

class VersusModel extends ChangeNotifier {
  static String _recipeName = "";
  static String _nutritionScore = "";
  static String _price = "";
  static String _image = "";
  static String _cookTime = "";

  String get recipeName => _recipeName;
  String get nutritionScore => _nutritionScore;
  String get price => _price;
  String get image => _image;
  String get cookTime => _cookTime;

  set recipeName(String recipeName) {
    _recipeName = recipeName;
    notifyListeners();
  }

  set nutritionScore(String nutritionScore) {
    _nutritionScore = nutritionScore;
    notifyListeners();
  }

  set price(String price) {
    _price = price;
    notifyListeners();
  }

  set image(String image) {
    _image = image;
    notifyListeners();
  }

  set cookTime(String cookTime) {
    _cookTime = cookTime;
    notifyListeners();
  }

  void saveJSON(JSON jsonInput)
}
