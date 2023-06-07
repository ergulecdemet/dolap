import 'package:dolap_app/contents/routings.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen"),
            TextButton(
                onPressed: () {
                  AppService().logout().then((value) {
                    if (value.status == true) {
                      Navigator.pushNamed(context, AppRoutes.login.path);
                    }
                  });
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
