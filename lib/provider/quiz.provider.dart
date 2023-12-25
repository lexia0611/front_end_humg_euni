// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print

import 'dart:convert';

import 'package:fe/model/question.quiz.model.dart';
import 'package:fe/model/quiz.answer.model.dart';
import 'package:fe/model/quiz.model.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuizProvider {
  QuizProvider._();

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<QuizModel>> getList({required String classId, int? status}) async {
    String filterStatus = "";
    if (status != null) {
      filterStatus = " and status:$status";
    }

    List<QuizModel> listData = [];
    try {
      var url = "$backendURL/api/quiz/get/page?filter=classId:'$classId'$filterStatus&sort=status,desc&sort=startTime";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          QuizModel item = QuizModel.fromMap(element);
          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  // <<<< Get list >>>>
  static Future<List<QuizModel>> getListForStudent({required String classId, int? status}) async {
    String filterStatus = "";
    if (status != null) {
      filterStatus = " and status:$status";
    }

    List<QuizModel> listData = [];
    try {
      var url = "$backendURL/api/quiz/get/page?filter=classId:'$classId'$filterStatus&sort=status,desc&sort=startTime";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? username = prefs.getString("username");
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          QuizModel item = QuizModel.fromMap(element);
          var answer = await getAnswer(idQuiz: item.id ?? 0, username: username ?? "");
          item.quizAnswerModel = answer;
          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<bool> create(QuizModel quizModel, List<QuestionQuizModel> listQuestion) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/quiz/post";
      var responseQuiz = await http.post(Uri.parse(url.toString()), headers: header, body: quizModel.toJson());
      if (responseQuiz.statusCode == 200) {
        var bodyConvert = jsonDecode(responseQuiz.body);
        QuizModel quizModelConvert = QuizModel.fromMap(bodyConvert);
        print("quizModelConvert: ${quizModelConvert.toMap()}");
        for (var element in listQuestion) {
          element.quizId = quizModelConvert.id;
          print("element: ${element.toMap()}");
          if (element.question != null && element.question != "" && element.quizId != null) {
            var urlQuestion = "$backendURL/api/question-quiz/post";
            await http.post(Uri.parse(urlQuestion.toString()), headers: header, body: element.toJson());
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  static Future<bool> update(QuizModel quizModel, List<QuestionQuizModel> listQuestion) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/quiz/put/${quizModel.id}";
      var responseQuiz = await http.put(Uri.parse(url.toString()), headers: header, body: quizModel.toJson());
      print("responseQuiz.statusCode ${responseQuiz.statusCode}");
      if (responseQuiz.statusCode == 200) {
        for (var element in listQuestion) {
          element.quizId = quizModel.id ?? 0;
          if (element.question != null && element.question != "" && element.quizId != null) {
            if (element.id == null) {
              var urlQuestion = "$backendURL/api/question-quiz/post";
              await http.post(Uri.parse(urlQuestion.toString()), headers: header, body: element.toJson());
            } else {
              var urlQuestion = "$backendURL/api/question-quiz/put/${element.id}";
              await http.put(Uri.parse(urlQuestion.toString()), headers: header, body: element.toJson());
            }
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  static delete(int index) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/quiz/del/$index";
      await http.delete(Uri.parse(url.toString()), headers: header);
    } catch (e) {
      print("Loi: $e");
    }
  }

  static deleteQuestion({int? id}) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/question-quiz/del/$id";
      await http.delete(Uri.parse(url.toString()), headers: header);
    } catch (e) {
      print("Loi: $e");
    }
  }

  // <<<< Get list >>>>
  static Future<List<QuestionQuizModel>> getListQuestion({required int idQuiz}) async {
    List<QuestionQuizModel> listData = [];
    try {
      var url = "$backendURL/api/question-quiz/get/page?filter=quizId:$idQuiz&sort=id";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          QuestionQuizModel item = QuestionQuizModel.fromMap(element);
          listData.add(item);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

//get answer
  static Future<QuizAnswerModel?> getAnswer({required int idQuiz, required String username}) async {
    QuizAnswerModel? listData;
    try {
      var url = "$backendURL/api/anser-quiz/get/page?filter=quizId:$idQuiz and username:'$username'";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        for (var element in bodyConvert['content']) {
          QuizAnswerModel item = QuizAnswerModel.fromMap(element);
          listData = item;
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<bool> sendAnswer({required int idQuiz, required String username, required String anser}) async {
    try {
      Map<String, String> header = await getHeader();
      var body = {"quizId": idQuiz, "username": username, "anser": anser};
      var url = "$backendURL/api/anser-quiz/post";
      await http.post(Uri.parse(url.toString()), headers: header, body: json.encode(body));
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  static Future<bool> updateAnswer({required QuizAnswerModel quizAnserModel}) async {
    try {
      Map<String, String> header = await getHeader();
      var url = "$backendURL/api/anser-quiz/put/${quizAnserModel.id}";
      await http.put(Uri.parse(url.toString()), headers: header, body: quizAnserModel.toJson());
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }
}
