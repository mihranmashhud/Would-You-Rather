import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  static String? _jwt;

  String? get jwt => _jwt;

  set jwt(String? jwt) {
    _jwt = jwt;
  }
}

