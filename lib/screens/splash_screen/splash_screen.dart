import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custome_text.dart';
import '../log_in_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () => checkUserIsLogged());
  }

  void checkUserIsLogged() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getBool(csharedLogged) != null) &&
        prefs.getBool(csharedLogged) == true) {
      try {
        await context.read<AuthProvider>().signInWithEmailAndPassword(
            context: context,
            email: prefs.getString(csharedEmail)!,
            password: prefs.getString(csharedPassword)!);
      } catch (e) {
        rethrow;
      }
    } else {
      Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.of(context)
              .pushReplacementNamed(LogInScreen.namedRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: CustomeText(
        color: Colors.white,
        label: 'Alphabets',
        size: 50,
        alignment: Alignment.center,
      )),
    );
  }
}
