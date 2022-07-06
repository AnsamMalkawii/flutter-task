import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../helpers/dbhelpers.dart';
import '../models/user.dart';
import '../screens/home_screen/home_screen.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;
  var _res;

  Future signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      _res = await DatabaseHelper.queryDatabase(email, password);
      print(_res);

      if (_res.length >= 1) {
        _user = User.fromjson(_res[0]);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setBool(csharedLogged, true);
        await sharedPreferences.setString(csharedEmail, email);
        print(
            'signing the user and saving ${sharedPreferences.getString(csharedEmail)}');

        await sharedPreferences.setString(csharedPassword, password);
        print(
            'signing the user and saving ${sharedPreferences.getString(csharedPassword)}');
        await Navigator.of(context).pushReplacementNamed(HomeScreen.namedRoute);
      }
    } catch (e) {
      throw e;
    }
  }

  int get userAge {
    DateTime birthdate = DateTime.fromMillisecondsSinceEpoch(_user!.birthdate);
    int age = DateTime.now().year - birthdate.year;
    return age;
  }
}
