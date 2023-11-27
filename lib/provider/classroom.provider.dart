// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:fe/model/sinh.vien.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ClassroomProvider {
  ClassroomProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  //Get sinh vieen lớp
  static Future<List<StudentModel>> getListStudent(String classId) async {
    List<StudentModel> listDataGet = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var headers = {"Content-Type": "application/json", "Authorization": "Bearer $token"};
      var body = {
        "filter": {"id_to_hoc": "${classId}"},
        "additional": {
          "paging": {"limit": 500, "page": 1},
          "ordering": [
            {"name": null, "order_type": 0}
          ]
        }
      };
      var url = "https://daotaodaihoc.humg.edu.vn/api/sch/w-locdssinhvientheotohoc";

      var response = await http.post(Uri.parse(url.toString()), headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['result'] == true) {
          for (var element in bodyConvert['data']['ds_sinh_vien']) {
            StudentModel item = StudentModel.fromMap(element);
            listDataGet.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listDataGet;
  }
}
