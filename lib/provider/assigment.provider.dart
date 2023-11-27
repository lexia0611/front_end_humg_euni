// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:fe/model/assigment.model.dart';
import 'package:fe/model/assigment.student.model.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:http/http.dart' as http;

class AssigmentProvider {
  AssigmentProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<AssigmentModel>> getList({required String classId, int? status}) async {
    String filterStatus = "";
    if (status != null) {
      filterStatus = " and status:$status";
    }
    List<AssigmentModel> listData = [];
    try {
      var url = "$baseUrl/api/assigment/get/page?filter=classId:'$classId'$filterStatus&sort=status,desc&sort=dueDay";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          AssigmentModel item = AssigmentModel.fromMap(element);
          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<void> create(AssigmentModel assigmentModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$baseUrl/api/assigment/post";
      await http.post(Uri.parse(url.toString()), headers: header, body: assigmentModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static update(AssigmentModel assigmentModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$baseUrl/api/assigment/put/${assigmentModel.id}";
      await http.put(Uri.parse(url.toString()), headers: header, body: assigmentModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static delete(int id) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$baseUrl/api/assigment/del/$id";
      await http.delete(Uri.parse(url.toString()), headers: header);
    } catch (e) {
      print("Loi: $e");
    }
  }

  static Future<AssigmentStudentModel?> getStudentFromAssigmentId({required int assigmentId, required String username}) async {
    AssigmentStudentModel? assigmentStudentModel;
    try {
      var url = "$baseUrl/api/assigment-student/get/page?filter=assigmentId:$assigmentId and username:'$username'";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['content'].runtimeType == List && bodyConvert['content'].isNotEmpty) {
          var item = bodyConvert['content'].first;
          assigmentStudentModel = AssigmentStudentModel.fromMap(item);
          print(assigmentStudentModel.toJson());
        }
      }
    } catch (e) {
      print("Loi: $e");
    }

    return assigmentStudentModel;
  }

  static Future<AssigmentStudentModel?> sendAssigment({required int assigmentId, required String username, required String fileName}) async {
    AssigmentStudentModel? assigmentStudentModel;
    try {
      var urlPost = "$baseUrl/api/assigment-student/post";
      var body = {"assigmentId": assigmentId, "username": username, "fileName": fileName};
      Map<String, String> header = await getHeader();
      var response = await http.post(Uri.parse(urlPost.toString()), headers: header, body: json.encode(body));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        assigmentStudentModel = AssigmentStudentModel.fromMap(bodyConvert);
      }
    } catch (e) {
      print("Loi: $e");
    }

    return assigmentStudentModel;
  }

  static Future<void> updateSendAssigment({required AssigmentStudentModel assigmentStudentModel}) async {
    try {
      var urlPost = "$baseUrl/api/assigment-student/put/${assigmentStudentModel.id ?? 0}";
      Map<String, String> header = await getHeader();
      await http.put(Uri.parse(urlPost.toString()), headers: header, body: assigmentStudentModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }
}
