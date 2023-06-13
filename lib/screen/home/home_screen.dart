import 'package:dolap_app/contents/routings.dart';
import 'package:dolap_app/model/product_model.dart';
import 'package:dolap_app/services/appservice.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserProductModel> products = <UserProductModel>[];
  @override
  void initState() {
    super.initState();
    AppService().getProducts().then((value) {
      if (value.status == true) {
        setState(() {
          products = value.data!;
        });
      }
    });
    AppService().profile().then((value) {
      if (value?.status == true) {
        setState(() {
          AppService.user = value!.data;
          AppService.user?.money = value.data?.money;
        });
      }
    });
  }

  bool isBuy = false;
  final int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.money.path);
          },
          child: const Text(
            "Para Yükle",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          AppService.user?.userType == int.parse("2")
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.categoryAdd.path);
                  },
                  icon: const Icon(Icons.category))
              : const Text(""),
        ],
        leading: IconButton(
            onPressed: () {
              AppService().logout().then((value) {
                if (value.status == true) {
                  Navigator.pushNamed(context, AppRoutes.login.path);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value.message.toString()),
                  ),
                );
              });
            },
            icon: const Icon(Icons.sensor_door_rounded)),
      ),
      floatingActionButton: AppService.user?.userType == int.parse("1")
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.productAdd.path);
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Hoşgeldin ${AppService.user?.name ?? ""}"),
                  Text("Bakiyeniz: ${AppService.user?.money ?? ""}")
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name ?? ""),
                    subtitle: Text(products[index].id.toString()),
                    leading: AppService.user?.userType == int.parse("2")
                        ? null
                        : IconButton(
                            onPressed: () {
                              AppService()
                                  .buyProduct(products[index].id!)
                                  .then((value) {
                                setState(() {});
                                if (value.status == true) {
                                  isBuy = _selected == index ? true : false;
                                  products.removeAt(index);
                                  print("alındı");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(value.message ?? "")));
                                }
                              });
                            },
                            icon: isBuy == false
                                ? const Icon(Icons.circle)
                                : const Icon(Icons.check_box)),
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
