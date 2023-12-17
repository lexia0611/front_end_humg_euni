// ignore_for_file: depend_on_referenced_packages, empty_catches, unused_import, unused_local_variable
import 'dart:convert';

import 'package:fe/model/user.model.dart';
import 'package:http/http.dart' as http;

String baseUrl = "http://192.168.68.80:8080";

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

    for (var element in listUSer) {
      if (element.username == username) {
        userModel = element;
      }
    }

    // var apiUrl = Uri.parse("https://daotaodaihoc.humg.edu.vn/api/auth/login");

    // var headers = {
    //   "Content-Type": "application/x-www-form-urlencoded",
    //   "Authorization": "Bearer ${base64Encode(utf8.encode('your_client_id:your_client_secret'))}",
    // };

    // try {
    //   var response = await http.post(apiUrl, headers: headers, body: loginData);
    //   if (response.statusCode == 200) {
    //     var data = json.decode(response.body);
    //     userModel = UserModel.fromMap(data);
    //     print(userModel.toMap());
    //   }
    // } catch (e) {
    //   print('Đã có lỗi xảy ra: $e');
    // }

    return userModel;
  }
}

List<UserModel> listUSer = [
  UserModel(
      id: "-5396071842627773540",
      roles: "SINHVIEN",
      name: "Nguyễn Văn Thắng",
      username: "1621050139",
      accessToken:
          "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ii01Mzk2MDcxODQyNjI3NzczNTQwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IjE2MjEwNTAxMzkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL2FjY2Vzc2NvbnRyb2xzZXJ2aWNlLzIwMTAvMDcvY2xhaW1zL2lkZW50aXR5cHJvdmlkZXIiOiJBU1AuTkVUIElkZW50aXR5IiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiI2MzIzNDg4Mjc2MTc0MTQwMzUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiU0lOSFZJRU4iLCJzZXNzaW9uIjoiLTc4MzAwODc3NDM2NzI5OTg2MjQiLCJkdnBjIjoiLTYyODQ5OTE3OTc4NDMzNTgxMzciLCJuYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG6r25nIiwicGFzc3R5cGUiOiIwIiwidWN2IjoiNzU0MzA1MTU2IiwicHJpbmNpcGFsIjoiMTYyMTA1MDEzOUBzdHVkZW50Lmh1bWcuZWR1LnZuIiwid2NmIjoiMCIsIm5iZiI6MTcwMjY1MjQ0OSwiZXhwIjoxNzAzMjU3MjQ5LCJpc3MiOiJlZHVzb2Z0IiwiYXVkIjoiYWxsIn0.3m7pk2F8TxnEO-cFN5HT6WUnneiJlt3GCxgcC-8pF_w"),
  UserModel(
      id: "-5396071842627773541",
      roles: "SINHVIEN",
      name: "Nguyễn Việt Phương",
      username: "1621050131",
      accessToken:
          "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ii01Mzk2MDcxODQyNjI3NzczNTQwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IjE2MjEwNTAxMzkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL2FjY2Vzc2NvbnRyb2xzZXJ2aWNlLzIwMTAvMDcvY2xhaW1zL2lkZW50aXR5cHJvdmlkZXIiOiJBU1AuTkVUIElkZW50aXR5IiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiI2MzIzNDg4Mjc2MTc0MTQwMzUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiU0lOSFZJRU4iLCJzZXNzaW9uIjoiLTc4MzAwODc3NDM2NzI5OTg2MjQiLCJkdnBjIjoiLTYyODQ5OTE3OTc4NDMzNTgxMzciLCJuYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG6r25nIiwicGFzc3R5cGUiOiIwIiwidWN2IjoiNzU0MzA1MTU2IiwicHJpbmNpcGFsIjoiMTYyMTA1MDEzOUBzdHVkZW50Lmh1bWcuZWR1LnZuIiwid2NmIjoiMCIsIm5iZiI6MTcwMjY1MjQ0OSwiZXhwIjoxNzAzMjU3MjQ5LCJpc3MiOiJlZHVzb2Z0IiwiYXVkIjoiYWxsIn0.3m7pk2F8TxnEO-cFN5HT6WUnneiJlt3GCxgcC-8pF_w"),
  UserModel(
      id: "-5396071842627773542",
      roles: "GIANGVIEN",
      name: "T.T.Chuyên",
      username: "1621050132",
      accessToken:
          "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ii01Mzk2MDcxODQyNjI3NzczNTQwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IjE2MjEwNTAxMzkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL2FjY2Vzc2NvbnRyb2xzZXJ2aWNlLzIwMTAvMDcvY2xhaW1zL2lkZW50aXR5cHJvdmlkZXIiOiJBU1AuTkVUIElkZW50aXR5IiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiI2MzIzNDg4Mjc2MTc0MTQwMzUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiU0lOSFZJRU4iLCJzZXNzaW9uIjoiLTc4MzAwODc3NDM2NzI5OTg2MjQiLCJkdnBjIjoiLTYyODQ5OTE3OTc4NDMzNTgxMzciLCJuYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG6r25nIiwicGFzc3R5cGUiOiIwIiwidWN2IjoiNzU0MzA1MTU2IiwicHJpbmNpcGFsIjoiMTYyMTA1MDEzOUBzdHVkZW50Lmh1bWcuZWR1LnZuIiwid2NmIjoiMCIsIm5iZiI6MTcwMjY1MjQ0OSwiZXhwIjoxNzAzMjU3MjQ5LCJpc3MiOiJlZHVzb2Z0IiwiYXVkIjoiYWxsIn0.3m7pk2F8TxnEO-cFN5HT6WUnneiJlt3GCxgcC-8pF_w"),
  UserModel(
      id: "-5396071842627773543",
      roles: "GIANGVIEN",
      name: "Nguyễn Thế Lộc",
      username: "1621050133",
      accessToken:
      "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ii01Mzk2MDcxODQyNjI3NzczNTQwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6IjE2MjEwNTAxMzkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL2FjY2Vzc2NvbnRyb2xzZXJ2aWNlLzIwMTAvMDcvY2xhaW1zL2lkZW50aXR5cHJvdmlkZXIiOiJBU1AuTkVUIElkZW50aXR5IiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiI2MzIzNDg4Mjc2MTc0MTQwMzUxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiU0lOSFZJRU4iLCJzZXNzaW9uIjoiLTc4MzAwODc3NDM2NzI5OTg2MjQiLCJkdnBjIjoiLTYyODQ5OTE3OTc4NDMzNTgxMzciLCJuYW1lIjoiTmd1eeG7hW4gVsSDbiBUaOG6r25nIiwicGFzc3R5cGUiOiIwIiwidWN2IjoiNzU0MzA1MTU2IiwicHJpbmNpcGFsIjoiMTYyMTA1MDEzOUBzdHVkZW50Lmh1bWcuZWR1LnZuIiwid2NmIjoiMCIsIm5iZiI6MTcwMjY1MjQ0OSwiZXhwIjoxNzAzMjU3MjQ5LCJpc3MiOiJlZHVzb2Z0IiwiYXVkIjoiYWxsIn0.3m7pk2F8TxnEO-cFN5HT6WUnneiJlt3GCxgcC-8pF_w"),
];
