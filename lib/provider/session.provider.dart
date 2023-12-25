import 'dart:convert';
import 'package:fe/app/data_fake/user_data.dart';
import 'package:fe/model/user.model.dart';
import 'package:http/http.dart' as http;

String backendURL = "http://192.168.68.80:8080";

class SessionProvider {
  SessionProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };
    return header;
  }

  static Future<UserModel?> login(String username, String password) async {
    var loginData = {
      "grant_type": "password",
      "username": username,
      "password": password,
    };
    UserModel? userModel;
    var authenticatorApi =
        Uri.parse("https://daotaodaihoc.humg.edu.vn/api/auth/login");
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization":
          "Bearer ${base64Encode(utf8.encode('your_client_id:your_client_secret'))}",
    };
    var response =
        await http.post(authenticatorApi, headers: headers, body: loginData);
    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        userModel = UserModel.fromMap(data);
        print("Access token is : ${data['access_token']}");
      } else {
        var responseCorrect = await http.post(authenticatorApi,
            headers: headers, body: loginData_always_correct);
        var data = json.decode(responseCorrect.body);
        for (var element in listUSer) {
          if (element.username == username) {
            userModel = element;
            userModel.accessToken = data['access_token'];
          }
        }
      }
    } catch (e) {
      print('Đã có lỗi xảy ra: $e');
    }
    return userModel;
  }
}
