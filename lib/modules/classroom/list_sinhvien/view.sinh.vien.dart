import 'package:fe/model/sinh.vien.model.dart';
import 'package:flutter/material.dart';

class ViewSinhvien extends StatelessWidget {
  final StudentModel sinhVienModel;
  const ViewSinhvien({super.key, required this.sinhVienModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Student details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FieldTextWidget(
                title: 'Full name',
                content: "${sinhVienModel.ho_lot ?? ""} ${sinhVienModel.ten ?? ""}",
              ),
              FieldTextWidget(
                title: 'Code',
                content: sinhVienModel.ma_sinh_vien ?? "",
              ),
              FieldTextWidget(
                title: 'Code class',
                content: sinhVienModel.ma_lop ?? "",
              ),
              FieldTextWidget(
                title: 'Name class',
                content: sinhVienModel.ten_lop ?? "",
              ),
              FieldTextWidget(
                title: 'Birthday',
                content: sinhVienModel.ngay_sinh ?? "",
              ),
              FieldTextWidget(
                title: 'Phone',
                content: sinhVienModel.dien_thoai ?? "",
              ),
              FieldTextWidget(
                title: 'Email',
                content: sinhVienModel.e_mail ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldTextWidget extends StatelessWidget {
  final String title;
  final String content;
  final Widget? widget;
  const FieldTextWidget({super.key, required this.title, required this.content, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: const Color(0xFFF0F0F0),
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF909090),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  (widget != null) ? widget! : SizedBox.shrink(),
                ],
              )),
        ],
      ),
    );
  }
}
