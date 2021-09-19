import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stack/stack.dart' as stack;

class VersusModel extends ChangeNotifier {
  static List<Map<String, dynamic>> _jsonResponse = [];
  static String _recipeName = "";
  static String _nutritionScore = "";
  static String _price = "";
  static String _image = "";
  static String _cookTime = "";
  static stack.Stack<Map> recipeStack = stack.Stack();

  List<Map<String, dynamic>> get jsonResponse => _jsonResponse;
  String get recipeName => _recipeName;
  String get nutritionScore => _nutritionScore;
  String get price => _price;
  String get image => _image;
  String get cookTime => _cookTime;

  set jsonResponse(List<Map<String, dynamic>> jsonResponse) {
    _jsonResponse = jsonResponse;
    notifyListeners();
  }

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

  void saveJSON(String jsonInput) {}
}
