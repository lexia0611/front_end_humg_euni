// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/message.model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatProvider {
  final firebaseInstance = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _groupCollection = FirebaseFirestore.instance.collection('chat');

  Future<List<MessageModel>> getMessAll(String id, bool isClass) async {
    List<MessageModel> listData = [];
    try {
      var url = "";
      if (isClass) {
        url = "$backendURL/api/message/get/page?filter=classId:'$id'";
      } else {
        url = "$backendURL/api/message/get/page?filter=groupId:$id";
      }
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            MessageModel item = MessageModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }

    return listData;
  }

  Stream<MessageModel> messageStream(String idClassroom) {
    return _groupCollection
        .doc(idClassroom)
        .collection('message')
        .orderBy("createTime", descending: true)
        .limit(1)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            return MessageModel.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toMapClass(),
        )
        .snapshots()
        .map((event) {
      var listChange = event.docChanges.where((element) => element.type == DocumentChangeType.added).map((e) {
        return e.doc.data() ?? MessageModel();
      }).toList();
      if (listChange.isNotEmpty) {
        return listChange.first;
      }
      return MessageModel();
    });
  }

  Stream<MessageModel> messageGroupStream(String idClassroom) {
    return FirebaseFirestore.instance
        .collection('group')
        .doc(idClassroom)
        .collection('message')
        .orderBy("createTime", descending: true)
        .limit(1)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            return MessageModel.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toMapGroup(),
        )
        .snapshots()
        .map((event) {
      var listChange = event.docChanges.where((element) => element.type == DocumentChangeType.added).map((e) {
        return e.doc.data() ?? MessageModel();
      }).toList();
      if (listChange.isNotEmpty) {
        return listChange.first;
      }
      return MessageModel();
    });
  }

  sendMessageText({required String message, String? idClassroom, int? idGroup, required bool isClass}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idSend = prefs.getString("id");
      String? name = prefs.getString("name");
      MessageModel data = MessageModel(
        classId: (isClass) ? idClassroom : "",
        groupId: idGroup,
        message: message,
        createUserId: idSend ?? "",
        createUserName: name ?? "",
        createUserImage: "",
        type: "text",
        linkFile: "",
        fileName: "",
      );
      //luu vao database
      var idMessDB = await saveMessToDB(data, isClass);
      //luu vao firebase
      if (idMessDB != null) {
        data.id = idMessDB;
        data.createTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        if (isClass) {
          await _groupCollection.doc(idClassroom.toString()).collection('message').doc(idMessDB.toString()).set(data.toMapClass());
        } else {
          await FirebaseFirestore.instance.collection('group').doc(idGroup.toString()).collection('message').doc(idMessDB.toString()).set(data.toMapGroup());
        }
      } else {
        var idMess = const Uuid().v4();
        data.id = 0;
        data.createTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        if (isClass) {
          await _groupCollection.doc(idClassroom.toString()).collection('message').doc(idMess).set(data.toMapClass());
        } else {
          await FirebaseFirestore.instance.collection('group').doc(idGroup.toString()).collection('message').doc(idMess).set(data.toMapGroup());
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
  }

  sendMessageImage({required String fileName, String? idClassroom, int? idGroup, required bool isClass}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idSend = prefs.getString("id");
      String? name = prefs.getString("name");

      MessageModel data = MessageModel(
        classId: (isClass) ? idClassroom : "",
        groupId: idGroup,
        message: "",
        createUserId: idSend ?? "",
        createUserName: name ?? "",
        createUserImage: "",
        type: "image",
        linkFile: "$backendURL/api/files/$fileName",
        fileName: fileName,
      );
      //luu vao database
      var idMessDB = await saveMessToDB(data, isClass);
      //luu vao firebase
      if (idMessDB != null) {
        data.id = idMessDB;
        data.createTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        if (isClass) {
          await _groupCollection.doc(idClassroom.toString()).collection('message').doc(idMessDB.toString()).set(data.toMapClass());
        } else {
          await FirebaseFirestore.instance.collection('group').doc(idGroup.toString()).collection('message').doc(idMessDB.toString()).set(data.toMapGroup());
        }
      } else {
        var idMess = const Uuid().v4();
        data.id = 0;
        data.createTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        if (isClass) {
          await _groupCollection.doc(idClassroom.toString()).collection('message').doc(idMess).set(data.toMapClass());
        } else {
          await FirebaseFirestore.instance.collection('group').doc(idGroup.toString()).collection('message').doc(idMess).set(data.toMapGroup());
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
  }

  sendMessageFile({required String fileName, String? idClassroom, int? idGroup, required bool isClass}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idSend = prefs.getString("id");
      String? name = prefs.getString("name");

      MessageModel data = MessageModel(
        classId: (isClass) ? idClassroom : "",
        groupId: idGroup,
        message: "",
        createUserId: idSend ?? "",
        createUserName: name ?? "",
        createUserImage: "",
        type: "file",
        linkFile: "$backendURL/api/files/$fileName",
        fileName: fileName,
      );
      //luu vao database
      var idMessDB = await saveMessToDB(data, isClass);
      //luu vao firebase
      if (idMessDB != null) {
        data.id = idMessDB;
        data.createTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        if (isClass) {
          await _groupCollection.doc(idClassroom.toString()).collection('message').doc(idMessDB.toString()).set(data.toMapClass());
        } else {
          await FirebaseFirestore.instance.collection('group').doc(idGroup.toString()).collection('message').doc(idMessDB.toString()).set(data.toMapGroup());
        }
      } else {
        var idMess = const Uuid().v4();
        data.id = 0;
        data.createTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        if (isClass) {
          await _groupCollection.doc(idClassroom.toString()).collection('message').doc(idMess).set(data.toMapClass());
        } else {
          await FirebaseFirestore.instance.collection('group').doc(idGroup.toString()).collection('message').doc(idMess).set(data.toMapGroup());
        }
      }
    } catch (e) {
      print("Loi: $e");
    }
  }

  Future<int?> saveMessToDB(MessageModel messageModel, bool isClass) async {
    int? value;
    try {
      var url = "$backendURL/api/message/post";
      await http.post(
        Uri.parse(url.toString()),
        headers: {'Content-type': 'application/json'},
        body: (isClass) ? messageModel.toJsonClass() : messageModel.toJsonGroup(),
      );
    } catch (e) {
      print("Error: $e");
    }
    return value;
  }

  deleteMess(int id) async {
    try {
      var url = "$backendURL/api/message/del/$id";
      await http.delete(Uri.parse(url.toString()), headers: {'Content-type': 'application/json'});
    } catch (e) {
      print("Loi: $e");
    }
  }

  void editMess(MessageModel messageModel, bool isClass) async {
    var url = "$backendURL/api/message/put/${messageModel.id}";
    await http.put(Uri.parse(url.toString()), headers: {'Content-type': 'application/json'}, body: (isClass) ? messageModel.toJsonClass() : messageModel.toJsonGroup());
  }
}

extension DateTimeExtension on DateTime {
  String get toMyDateTime {
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss').format(this);
    return formattedDate;
  }
}
