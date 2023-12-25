import 'dart:convert';

import 'package:fe/model/group.member.dart';
import 'package:fe/model/group.model.dart';
import 'package:fe/provider/classroom.provider.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:http/http.dart' as http;

class GroupProvider {
  GroupProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<GroupModel>> getList({required String classId, int? status}) async {
    String filterStatus = "";
    if (status != null) {
      filterStatus = " and status:$status";
    }
    List<GroupModel> listData = [];
    try {
      var url = "$backendURL/api/group/get/page?filter=classId:'$classId'$filterStatus";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            GroupModel item = GroupModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<void> createGroup(GroupModel groupModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/group/post";
      await http.post(Uri.parse(url.toString()), headers: header, body: groupModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static Future<void> editGroup(GroupModel groupModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/group/put/${groupModel.id}";
      await http.put(Uri.parse(url.toString()), headers: header, body: groupModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static Future<void> deleteGroup(int idGroup) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/group/del/$idGroup";
      await http.delete(Uri.parse(url.toString()), headers: header);
    } catch (e) {
      print("Loi: $e");
    }
  }

  static Future<GroupMemberModel> addMember(int idGroup, String username) async {
    GroupMemberModel groupMemberModel = GroupMemberModel(groupId: idGroup, username: username);
    try {
      var body = {"groupId": idGroup, "username": username};
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/member-group/post";
      var response = await http.post(
        Uri.parse(url.toString()),
        headers: header,
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        groupMemberModel.id = int.tryParse(bodyConvert.toString());
      }
    } catch (e) {
      print("Loi: $e");
    }
    return groupMemberModel;
  }

  // <<<< Get list >>>>
  static Future<List<GroupMemberModel>> getListStudentForGroup({required int groupId, required String classId}) async {
    List<GroupMemberModel> listData = [];
    try {
      var url = "$backendURL/api/member-group/get/page?filter=groupId:$groupId";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          GroupMemberModel item = GroupMemberModel.fromMap(element);
          listData.add(item);
          var listStudentClass = await ClassroomProvider.getListStudent(classId);
          for (var element in listData) {
            for (var element2 in listStudentClass) {
              if (element.username == element2.ma_sinh_vien) {
                element.student = element2;
              }
            }
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<void> deleteMemberGroup(int idMemberGroup) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/member-group/del/$idMemberGroup";
      await http.delete(Uri.parse(url.toString()), headers: header);
    } catch (e) {
      print("Loi: $e");
    }
  }

  // <<<< Get list for student>>>>
  static Future<List<GroupModel>> getListForStudent({required String username}) async {
    List<GroupModel> listData = [];
    try {
      List<GroupMemberModel> listGroupMemberModel = [];
      var url = "$backendURL/api/member-group/get/page?filter=username:'$username'";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          GroupMemberModel item = GroupMemberModel.fromMap(element);
          listGroupMemberModel.add(item);
        }
      }
      for (var element in listGroupMemberModel) {
        var urlGroup = "$backendURL/api/group/get/${element.groupId}";
        var responseGroup = await http.get(Uri.parse(urlGroup.toString()));
        if (responseGroup.statusCode == 200) {
          var bodyConvert = jsonDecode(responseGroup.body);
          GroupModel item = GroupModel.fromMap(bodyConvert);
          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }
}
