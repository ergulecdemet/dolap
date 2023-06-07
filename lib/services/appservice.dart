import 'dart:convert';

import 'package:dolap_app/model/sign_model.dart';
import 'package:dolap_app/model/status_model.dart';
import 'package:dolap_app/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  static String domain = "http://10.10.27.19:5000/api/";
  static String? token;
  static String? user;

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
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // sharedPreferences.setString('token', jresponse['data']['token']);
      // token = jresponse['data']['token'];

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
      }).timeout(const Duration(seconds: 10));
      user = response.body;
    } catch (e) {
      StatusModel(message: "Beklenmedik hata", status: false);
      return null;
    }
    return ProfileModel.fromJson(json.decode(user!));
  }

  Future<StatusModel> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    return StatusModel(message: "Başarılı", status: true);
  }
}
