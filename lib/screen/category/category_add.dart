import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:flutter/material.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category Ekle")),
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFromField(
              hinText: "kategori adı", controller: _categoryNameController),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text(
                "Ekle",
              ))
        ],
      )),
    );
  }
}
