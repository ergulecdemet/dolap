import 'package:dolap_app/contents/routings.dart';
import 'package:dolap_app/model/product_model.dart';
import 'package:dolap_app/model/user_model.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AppService appService = AppService();
  List<UserProductModel> products = <UserProductModel>[];
  UserProfileModel user = UserProfileModel();

  @override
  void initState() {
    super.initState();
    AppService().getProducts().then((value) {
      if (value.status == true) {
        setState(() {
          products = value.data!;
        });
      } //copilot yazdı bunu öğren
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.categoryAdd.path);
              },
              icon: const Icon(Icons.category))
        ],
        leading: IconButton(
            onPressed: () {
              AppService().logout().then((value) {
                if (value.status == true) {
                  Navigator.pushNamed(context, AppRoutes.login.path);
                }
              });
            },
            icon: const Icon(Icons.sensor_door_rounded)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.productAdd.path);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hoşgeldin ${user.name ?? ""} "),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name ?? ""),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
