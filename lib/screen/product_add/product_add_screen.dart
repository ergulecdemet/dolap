import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Ekle"),
      ),
      backgroundColor: const Color.fromARGB(248, 211, 255, 182),
      body: Form(
          key: _formKey,
          child: Center(
            child: Wrap(
              runSpacing: 10,
              children: [
                CustomTextFromField(
                    hinText: "ürün", controller: _nameController),
                CustomTextFromField(
                    hinText: "ürün açıklama",
                    controller: _descriptionController),
                CustomTextFromField(
                    hinText: "ürün fiyat", controller: _priceController),
                CustomTextFromField(
                    hinText: "ürün kategori", controller: _categoryController),
                Center(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Ürün Ekle")))
              ],
            ),
          )),
    );
  }
}
