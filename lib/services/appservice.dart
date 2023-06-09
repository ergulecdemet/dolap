import 'dart:convert';

import 'package:dolap_app/model/caetgory_get_model.dart';
import 'package:dolap_app/model/category_add_model.dart';
import 'package:dolap_app/model/product_model.dart';
import 'package:dolap_app/model/sign_model.dart';
import 'package:dolap_app/model/status_model.dart';
import 'package:dolap_app/model/user_model.dart';
import 'package:dolap_app/model/user_product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  static String domain = "http://10.10.27.19:5000/api/";
  static String? token;
  static UserProfileModel? user;

  Future<StatusModel> register(SignModel signModel) async {
    try {
      var client = http.Client();
      var response =
          await client.post(Uri.parse('${domain}auth/register'), body: {
        "name": signModel.name,
        "surname": signModel.surname,
        "email": signModel.email,
        "password": signModel.password,
        "user_type": signModel.userType
      }, headers: {
        "Accept": "application/json",
      }).timeout(const Duration(seconds: 10));
      var jresponse = json.decode(response.body);
      return StatusModel.fromJson(jresponse);
    } catch (e) {
      return StatusModel(message: "Beklenemdik hata", status: false);
    }
  }

  Future<StatusModel> login(String email, String password) async {
    try {
      var client = http.Client();
      var response = await client.post(Uri.parse('${domain}auth/login'), body: {
        'email': email,
        'password': password,
      }, headers: {
        "Accept": "application/json",
      }).timeout(const Duration(seconds: 10));
      var jresponse = json.decode(response.body);
      token = jresponse['token'];
      print("tokennnnnnn $token");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance().then((value) {
        value.setString('token', jresponse['token']);
        return value;
      });

      return StatusModel.fromJson(jresponse);
    } catch (e) {
      return StatusModel(message: "Beklenmedik", status: false);
    }
  }

  Future<ProfileModel?> profile() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse('${domain}auth/profile'), headers: {
        "Accept": "applicatin/json",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 10));
      user = json.decode(response.body);
      // return ProfileModel.fromJson(user!.toJson());
    } catch (e) {
      StatusModel(message: "Beklenmedik hata", status: false);
      return null;
    }
    return null;
  }

  Future<StatusModel> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    return StatusModel(message: "Başarılı", status: true);
  }

  Future<ProductModel> getProducts() async {
    var client = http.Client();

    try {
      var response = await client.get(Uri.parse('${domain}products'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 10));
      debugPrint(token);
      if (response.statusCode == 200) {
        var jresponse = json.decode(response.body);

        return ProductModel.fromJson(jresponse);
      } else {
        return ProductModel(message: "Beklenmedik hata", status: false);
      }
    } catch (e) {
      return ProductModel(message: "Beklenmedik hata", status: false);
    } finally {
      client.close();
    }
  }

  Future<StatusModel?> addProduct(UserProModel userProductModel) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('${domain}products'), body: {
        "name": userProductModel.name,
        "description": userProductModel.description,
        "price": userProductModel.price.toString(),
        "category_id": userProductModel.categoryId.toString(),
      }, headers: {
        "Accept": "json/application",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 10));
      var jresponse = json.decode(response.body);
      return StatusModel.fromJson(jresponse);
    } catch (e) {
      StatusModel(message: "Beklenmedik hata", status: false);
    }
    return null;
  }

  Future<StatusModel?> addCategory(CategoryAddModel categoryAddModel) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('${domain}category'), body: {
        "name": categoryAddModel.name,
        "description": categoryAddModel.description,
      }, headers: {
        "Accept": "json/application",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 10));
      var jresponse = json.decode(response.body);
      return StatusModel.fromJson(jresponse);
    } catch (e) {
      StatusModel(message: "Beklenmedik hata", status: false);
    }
    return null;
  }

  Future<MyCategoryGetModel> getCategory() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse('${domain}category'), headers: {
        "Accept": "json/application",
        "Authorization": "Bearer $token",
      }).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        var jresponse = json.decode(response.body);
        return MyCategoryGetModel.fromJson(jresponse);
      } else {
        return MyCategoryGetModel(
            message: "Beklenmedik hata var", status: false);
      }
    } catch (e) {
      return MyCategoryGetModel(message: "Beklenmedik hata var", status: false);
    } finally {
      client.close();
    }
  }
}

 // SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance().then(
    //   (value) {
    //     token = value.getString('token');
    //     return value;
    //   },
    // );
