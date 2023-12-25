// ignore_for_file: unused_import

import 'dart:convert';

import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.answer.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/model/vote.model.dart';
import 'package:fe/model/vote.option.model.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VoteProvider {
  VoteProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  static Future<VoteModel?> getVoteModel(String? classId) async {
    VoteModel? voteModel;
    try {
      var url = "$backendURL/api/vote/get/page?filter=classId:'$classId' and status:1";
      var response = await http.get(Uri.parse(url.toString()));
      print("object: ${response.body}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['content'].length > 0) {
          VoteModel item = VoteModel.fromMap(bodyConvert['content'].first);
          voteModel = item;
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return voteModel;
  }

  static Future<bool> createVote(VoteModel voteModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/vote/post";
      await http.post(Uri.parse(url.toString()), headers: header, body: voteModel.toJson());
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  // <<<< Get list >>>>
  static Future<List<VoteOptionModel>> getListOptionVote({required int voteId}) async {
    List<VoteOptionModel> listData = [];
    try {
      var url = "$backendURL/api/vote-option/get/page?filter=voteId:'$voteId'&sort=id";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          VoteOptionModel item = VoteOptionModel.fromMap(element);
          var data = item.data ?? "";
          List<String> userList = data.split(',');
            item.count = userList.length-1;

          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<bool> createVoteOption(VoteOptionModel voteOptionModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/vote-option/post";
      await http.post(Uri.parse(url.toString()), headers: header, body: voteOptionModel.toJson());
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  static updateVote(VoteModel voteModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/vote/put/${voteModel.id ?? 0}";
      await http.put(Uri.parse(url.toString()), headers: header, body: voteModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }

  static updateVoteOption(VoteOptionModel voteOptionModel) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/vote-option/put/${voteOptionModel.id ?? 0}";
      await http.put(Uri.parse(url.toString()), headers: header, body: voteOptionModel.toJson());
    } catch (e) {
      print("Loi: $e");
    }
  }
}
