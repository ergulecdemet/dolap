import 'package:dolap_app/contents/routings.dart';
import 'package:dolap_app/model/category_add_model.dart';
import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:dolap_app/services/appservice.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Ekle"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.categoryList.path);
              },
              icon: const Icon(Icons.looks_5_rounded))
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFromField(
                  hinText: "kategori adı", controller: _categoryNameController),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AppService()
                          .addCategory(CategoryAddModel(
                              name: _categoryNameController.text))
                          .then((value) {
                        if (value?.status == true) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value!.message.toString()),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: const Text(
                    "Ekle",
                  ))
            ],
          )),
    );
  }
}
