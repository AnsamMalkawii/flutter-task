import 'package:flutter/material.dart';

import '../helpers/dbhelpers.dart';
import '../models/alphabets.dart';

class AlpabetsProviders with ChangeNotifier {
  List<Alphabets> _alphabets = [];
  List<Alphabets> get alphabets => _alphabets;

  Future<void> getAndFetchAlphabets() async {
    _alphabets = [];
    var data = await DatabaseHelper.getAlphabetsData();
    for (var i in data) {
      _alphabets.add(Alphabets.fromJson(i));
    }
    print(_alphabets);
    notifyListeners();
  }
}
