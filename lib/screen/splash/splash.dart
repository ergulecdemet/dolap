import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../contents/routings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static String? token;
  Future splashScreen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance()
        .timeout(const Duration(seconds: 3));
    token = sharedPreferences.getString('token');
    AppService.token = token;

    AppService().profile().then((value) {
      if (value != null && value.status == true) {
        setState(() {
          AppService.user = value.data;
        });

        Navigator.pushNamed(
          context,
          AppRoutes.home.path,
        );
      } else {
        Navigator.pushNamed(context, AppRoutes.login.path);
      }
    });

    return token;
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
