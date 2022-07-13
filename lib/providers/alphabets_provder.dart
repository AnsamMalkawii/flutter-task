import 'package:flutter/material.dart';

import '../helpers/dbhelpers.dart';
import '../models/alphabets.dart';

class AlpabetsProviders with ChangeNotifier {
  List<Alphabets> _alphabets = [];
  List<Alphabets> get alphabets => _alphabets;

  Future<void> getAndFetchAlphabets() async {
    _alphabets = [];
    var alpha = await DatabaseHelper.getAlphabetsData();
    for (var i in alpha) {
      _alphabets.add(Alphabets.fromJson(i));
    }
    notifyListeners();
  }
}
