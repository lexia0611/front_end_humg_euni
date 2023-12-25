import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

Future<String?> handleUploadFileAll() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
  if (result != null) {
    try {
      for (var element in result.files) {
        String path = element.path ?? "";
        var fileNameUpload = await uploadFile(File(path));
        fileName = fileNameUpload;
      }
    } catch (e) {
      print("Loi1: $e");
    }
  }

  return fileName;
}

Future<String?> handleUploadImage() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null) {
    try {
      for (var element in result.files) {
        String path = element.path ?? "";
        var fileNameUpload = await uploadFile(File(path));
        fileName = fileNameUpload;
      }
    } catch (e) {
      //Do nothing
    }
  } else {}

  return fileName;
}

Future<String?> uploadFile(File file) async {
  try {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$backendURL/api/upload"),
    );
    var data = await http.MultipartFile.fromPath(
      'file',
      file.path,
    );
    request.files.add(data);
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();
    var body = json.decode(result);
    if (body.containsKey("1")) {
      return body['1'];
    }
    return "Chưa có báo cáo, nhấn vào để tải lên.";
  } catch (e) {
    return null;
  }
}

Future<void> downloadFile(BuildContext context, String fileName) async {
  try {
    final response = await http.get(Uri.parse("$backendURL/api/files/$fileName"));

    if (response.statusCode == 200) {
      final documentsDirectory = await getExternalStorageDirectory();
      final filePath = '${documentsDirectory?.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã tải file về tại $filePath'),
          duration: const Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    }
  } catch (e) {
    print("error: $e");
  }
}

Future<void> copyFile(BuildContext context, String fileName) async {
  var url="$backendURL/api/files/$fileName";
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
  try {
    final response = await http.get(Uri.parse("$backendURL/api/files/$fileName"));
    if (response.statusCode == 200) {
      copyToClipboard(url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã copy link vào Clipboard !'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    }
  } catch (e) {
    print("error: $e");
  }
}

