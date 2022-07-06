import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'providers/alphabets_provder.dart';
import 'providers/auth_provider.dart';
import 'routes.dart';
import 'screens/log_in_screen/login_screen.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlpabetsProviders()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: routes,
        home: SplashScreen(),
      ),
    );
  }
}
