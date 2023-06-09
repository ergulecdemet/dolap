import 'package:dolap_app/contents/routings.dart';
import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 10,
              children: [
                CustomTextFromField(
                    hinText: "email", controller: _emailController),
                CustomTextFromField(
                    hinText: "password", controller: _passwordController),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppService()
                            .login(
                                _emailController.text, _passwordController.text)
                            .timeout(const Duration(seconds: 10))
                            .then((value) {
                          if (value.status == true) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.home.path,
                            );
                          }
                        });
                      }
                    },
                    child: const Text("Giriş")),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register.path);
                    },
                    child: const Text("Kayıt Ol"))
              ],
            ),
          )),
    );
  }
}
