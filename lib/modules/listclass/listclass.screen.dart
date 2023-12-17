import 'package:animation_list/animation_list.dart';
import 'package:fe/app/widgets/will.pop.scope.dart';
import 'package:fe/model/class.model.dart';
import 'package:fe/modules/classroom/classroom.screen.dart';
import 'package:fe/modules/login/ui/login.screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortOption {tenMon, phong}

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
      tenMon: "Logic Đại Cương",
      nhomTo: "01",
      tkb: "08/02/20  28/03/20",
      tuGio: "06:45",
      denGio: "08:45",
      gv: "T.T.Chuyên",
      phong: "HNBG309",
    ),
    ClassModel(
      id: "-6903517977552750442",
      tenMon: "Giải Tích 1",
      nhomTo: "01",
      tkb: "08/02/20  28/03/20",
      tuGio: "06:45",
      denGio: "08:45",
      gv: "T.T.Chuyên",
      phong: "HNBG201",
    ),
  ];
  SortOption _sortOption = SortOption.tenMon;
  getData() async {
    // var listClassNew = await ClassroomProvider.getListClass(20191, 1); //
    // setState(() {
    //   listClass = listClassNew;
    // });
    setState(() {
      listClass.sort((a, b) {
        if (_sortOption == SortOption.tenMon) {
          return b.tenMon!.compareTo(a.tenMon!);
        } else {
          return b.phong!.compareTo(a.phong!);
        }
      });
    });
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
          centerTitle: true,
          title: const Text(
            "Classroom",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SortOption>(
                    isExpanded: true,
                    value: _sortOption,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    onChanged: (SortOption? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _sortOption = newValue;
                          getData();
                        });
                      }
                    },
                    items: const <DropdownMenuItem<SortOption>>[
                      DropdownMenuItem<SortOption>(
                        value: SortOption.tenMon,
                        child: Text('Sắp xếp theo tên môn'),
                      ),
                      DropdownMenuItem<SortOption>(
                        value: SortOption.phong,
                        child: Text('Sắp xếp theo phòng'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: AnimationList(
                    children: listClass.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 79, 79, 79).withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(3, 3),
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
                                style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.clip,
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Teacher: ${item.gv ?? ""}",
                                style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Room: ${item.phong ?? ""}",
                                style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
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
            ],
          ),
        ),
      ),
    );
  }
}