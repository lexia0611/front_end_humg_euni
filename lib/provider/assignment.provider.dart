import 'dart:convert';

import 'package:fe/model/assignment.model.dart';
import 'package:fe/model/assignment.student.model.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:http/http.dart' as http;

class AssignmentProvider {
  AssignmentProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  //Request list Assignment
  static Future<List<AssignmentModel>> getList({required String classId, int? status}) async {
    String filterStatus = "";
    if (status != null) {
      filterStatus = " and status:$status";
    }
    List<AssignmentModel> listData = [];
    try {
      var url = "$backendURL/api/assigment/get/page?filter=classId:'$classId'$filterStatus&sort=status,desc&sort=dueDay";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          AssignmentModel item = AssignmentModel.fromMap(element);
          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<void> create(AssignmentModel assignmentModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/assigment/post";
      await http.post(Uri.parse(url.toString()), headers: header, body: assignmentModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static update(AssignmentModel assignmentModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/assigment/put/${assignmentModel.id}";
      await http.put(Uri.parse(url.toString()), headers: header, body: assignmentModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static delete(int id) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/assigment/del/$id";
      await http.delete(Uri.parse(url.toString()), headers: header);
    } catch (e) {
      print("Loi: $e");
    }
  }

  static Future<AssignmentStudentModel?> getStudentFromAssigmentId({required int assignmentId, required String username}) async {
    AssignmentStudentModel? assignmentStudentModel;
    try {
      var url = "$backendURL/api/assigment-student/get/page?filter=assigmentId:$assignmentId and username:'$username'";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['content'].runtimeType == List && bodyConvert['content'].isNotEmpty) {
          var item = bodyConvert['content'].first;
          assignmentStudentModel = AssignmentStudentModel.fromMap(item);
          print(assignmentStudentModel.toJson());
        }
      }
    } catch (e) {
      print("Loi: $e");
    }

    return assignmentStudentModel;
  }

  static Future<AssignmentStudentModel?> sendAssignment({required int assignmentId, required String username, required String fileName}) async {
    AssignmentStudentModel? assignmentStudentModel;
    try {
      var urlPost = "$backendURL/api/assigment-student/post";
      var body = {"assigmentId": assignmentId, "username": username, "fileName": fileName};
      Map<String, String> header = await getHeader();
      var response = await http.post(Uri.parse(urlPost.toString()), headers: header, body: json.encode(body));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        assignmentStudentModel = AssignmentStudentModel.fromMap(bodyConvert);
      }
    } catch (e) {
      print("Loi: $e");
    }

    return assignmentStudentModel;
  }

  static Future<void> updateSendAssignment({required AssignmentStudentModel assignmentStudentModel}) async {
    try {
      var urlPost = "$backendURL/api/assigment-student/put/${assignmentStudentModel.id ?? 0}";
      Map<String, String> header = await getHeader();
      await http.put(Uri.parse(urlPost.toString()), headers: header, body: assignmentStudentModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }
}
