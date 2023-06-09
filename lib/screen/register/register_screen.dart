import 'package:dolap_app/contents/routings.dart';
import 'package:dolap_app/model/sign_model.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _typeUserController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _typeUserController.dispose();
  }

  late SignModel signModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 10,
              children: [
                CustomTextFromField(
                  controller: _nameController,
                  hinText: "isim",
                ),
                CustomTextFromField(
                  controller: _surnameController,
                  hinText: "soyisim",
                ),
                CustomTextFromField(
                  controller: _emailController,
                  hinText: "e-mail",
                ),
                CustomTextFromField(
                  controller: _typeUserController,
                  hinText: "Tip",
                ),
                CustomTextFromField(
                  controller: _passwordController,
                  hinText: "şifre",
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AppService()
                            .register(SignModel(
                                name: _nameController.text,
                                surname: _surnameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                userType: _typeUserController.text))
                            .timeout(const Duration(seconds: 2))
                            .then((value) {
                          if (value.status == true) {
                            Navigator.pushNamed(context, AppRoutes.home.path);
                          }
                        });
                      }
                    },
                    child: const Text("Kayıt Ol"))
              ],
            ),
          )),
    );
  }
}

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    required this.hinText,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final String hinText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Lütfen bir değer giriniz";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hinText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
