import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';

class Alphabets with ChangeNotifier {
  int id;
  String arabicAlpha;
  String example;
  bool isChossed = false;

  Alphabets(
      {required this.id, required this.arabicAlpha, required this.example});

  factory Alphabets.fromJson(Map<String, dynamic> jsonData) {
    return Alphabets(
        id: jsonData['id'],
        arabicAlpha: jsonData['arabicAlpha'],
        example: jsonData['example']);
  }

  toJson() {
    return {cId: id, cArabicAlphabet: arabicAlpha, cExample: example};
  }

  toggleIsChoosed() {
    isChossed = !isChossed;
    notifyListeners();
  }
}
