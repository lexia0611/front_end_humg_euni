// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:animation_list/animation_list.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/model/sinh.vien.model.dart';
import 'package:fe/modules/classroom/list_sinhvien/view.sinh.vien.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListSinhVienScreen extends StatefulWidget {
  final ClassModel classModel;
  const ListSinhVienScreen({super.key, required this.classModel});

  @override
  State<ListSinhVienScreen> createState() => _ListSinhVienScreenState();
}

class _ListSinhVienScreenState extends State<ListSinhVienScreen> {
  List<StudentModel> listData = [];

  getData() async {
    List<StudentModel> listDataGet = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var headers = {"Content-Type": "application/json", "Authorization": "Bearer $token"};
      var body = {
        "filter": {"id_to_hoc": "${widget.classModel.id}"},
        "additional": {
          "paging": {"limit": 500, "page": 1},
          "ordering": [
            {"name": null, "order_type": 0}
          ]
        }
      };
      var url = "https://daotaodaihoc.humg.edu.vn/api/sch/w-locdssinhvientheotohoc";

      var response = await http.post(Uri.parse(url.toString()), headers: headers, body: json.encode(body));

      print(response.body);
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
    setState(() {
      listData = listDataGet;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.classModel.tenMon ?? "",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: AnimationList(
        children: listData.map((element) {
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 79, 79, 79).withOpacity(0.5),
                  blurRadius: 8,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                // ViewSinhvien
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ViewSinhvien(
                      sinhVienModel: element,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${element.ho_lot ?? ""} ${element.ten ?? ""} - ${element.ma_sinh_vien}",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "${element.ten_lop}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Email: ${element.e_mail}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Phone: ${element.dien_thoai ?? ""}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
