import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../contents/routings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future splashScreen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance()
        .timeout(const Duration(seconds: 3));
    var token = sharedPreferences.getString('token');

    if (token != null) {
      Navigator.pushNamed(context, AppRoutes.home.path);
    } else {
      Navigator.pushNamed(context, AppRoutes.login.path);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
