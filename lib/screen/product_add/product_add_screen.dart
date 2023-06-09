import 'package:dolap_app/model/caetgory_get_model.dart';
import 'package:dolap_app/model/user_product_model.dart';
import 'package:dolap_app/screen/register/register_screen.dart';
import 'package:dolap_app/services/appservice.dart';
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
  var selectedCatgeory;
  // @override
  // void dispose() {
  //   super.dispose();
  //   _nameController.dispose();
  //   _priceController.dispose();
  //   _descriptionController.dispose();
  //   _categoryController.dispose();
  // }
  List<MyCatgeoryDataModel> catgories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppService().getCategory().then((value) {
      if (value.status == true) {
        setState(() {
          catgories = value.data!;
        });
      }
    });
  }

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
                DropdownButton<String>(
                  value: selectedCatgeory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCatgeory = newValue!;
                    });
                  },
                  items: catgories.map((MyCatgeoryDataModel value) {
                    return DropdownMenuItem<String>(
                      value: value.name.toString(),
                      child: Text(value.name.toString()),
                    );
                  }).toList(),
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (selectedCatgeory == null ||
                              selectedCatgeory.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Kategori Seçiniz")));
                          }
                          if (_formKey.currentState!.validate()) {
                            await AppService()
                                .addProduct(UserProModel(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              price: _priceController.text,
                              categoryId: selectedCatgeory,
                            ))
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
                          // if (_formKey.currentState!.validate()) {
                          //   await AppService()
                          //       .addProduct(UserProModel(
                          //     name: _nameController.text,
                          //     description: _descriptionController.text,
                          //     price: _priceController.text,
                          //     categoryId: selectedCatgeory,
                          //   ))
                          //       .then((value) {
                          //     if (value?.status == true) {
                          //       Navigator.pop(context);
                          //     } else {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text(value!.message.toString()),
                          //         ),
                          //       );
                          //     }
                          //   });
                          // }
                        },
                        child: const Text("Ürün Ekle")))
              ],
            ),
          )),
    );
  }
}
