// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:animation_list/animation_list.dart';
import 'package:fe/app/widgets/will.pop.scope.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/modules/classroom/classroom.screen.dart';
import 'package:fe/modules/login/ui/login.screen.dart';
// import 'package:fe/provider/classroom.provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListClassScreen extends StatefulWidget {
  final bool isTeacher;
  const ListClassScreen({super.key, required this.isTeacher});

  @override
  State<ListClassScreen> createState() => _ListClassScreenState();
}

class _ListClassScreenState extends State<ListClassScreen> {
  List<ClassModel> listClass = [
    ClassModel(
      id: "-6903517977552750442",
      tenMon: "Phát triển ứng dụng cho thiết bị di động",
      nhomTo: "01",
      tkb: "08/02/20  28/03/20",
      tuGio: "06:45",
      denGio: "08:45",
      gv: "T.T.Chuyên",
      phong: "HNBG301",
    ),
    ClassModel(
      id: "-6903517977552750442",
      tenMon: "Phát triển ứng dụng cho thiết bị di động",
      nhomTo: "01",
      tkb: "08/02/20  28/03/20",
      tuGio: "06:45",
      denGio: "08:45",
      gv: "T.T.Chuyên",
      phong: "HNBG301",
    ),
  ];
  //
  getData() async {
    // var listClassNew = await ClassroomProvider.getListClass(20191, 1); //
    // setState(() {
    //   listClass = listClassNew;
    // });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPS(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LoginScreen(),
                ),
              );
            },
            child: Icon(
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(
              "Classroom",
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {},
              child: Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: AnimationList(
              children: listClass.map((item) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 105,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 79, 79, 79).withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? idUser = prefs.getString("id");
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ClassRoomScreen(
                        classModel: item,
                        idUser: idUser ?? "",
                        isTeacher: widget.isTeacher,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          item.tenMon ?? "",
                          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Teacher: ${item.gv ?? ""}",
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Room: ${item.phong ?? ""}",
                          style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
        ),
      ),
    );
  }
}
