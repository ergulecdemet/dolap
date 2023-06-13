import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class MoneyScreen extends StatefulWidget {
  const MoneyScreen({super.key});

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  final TextEditingController _moneyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _moneyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bakkiye Yükle"),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: CustomTextFromField(
                  hinText: "Para miktarı yazınız",
                  controller: _moneyController),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await AppService()
                        .addMoney(int.parse(_moneyController.text))
                        .then((value) {
                      if (value.status == true) {
                        Navigator.pop(context);
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.message!)));
                      }
                    });
                  }
                },
                child: const Text("YÜKLE"))
          ],
        ),
      ),
    );
  }
}
