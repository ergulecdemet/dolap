import 'package:dolap_app/model/caetgory_get_model.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<MyCatgeoryDataModel> categories = <MyCatgeoryDataModel>[];

  @override
  void initState() {
    super.initState();
    AppService().getCategory().then((value) {
      if (value.status == true) {
        setState(() {
          categories = value.data!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category List"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index].name.toString()),
          );
        },
      ),
    );
  }
}
