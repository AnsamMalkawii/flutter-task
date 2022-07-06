import 'package:flutter/material.dart';

import 'screens/home_screen/home_screen.dart';
import 'screens/log_in_screen/login_screen.dart';

Map<String, WidgetBuilder> routes = {
  HomeScreen.namedRoute: (_) => HomeScreen(),
  LogInScreen.namedRoute: (_) => LogInScreen()
};
