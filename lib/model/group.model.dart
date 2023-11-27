// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/model/group.member.dart';

class GroupModel {
  int? id;
  String? classId;
  String? name;
  String? avatar;
  String? description;
  String? createTime;
  int? status;
  int? countSV;
  List<GroupMemberModel>? listGroupMemberModel;
  GroupModel({this.id, this.classId, this.name, this.avatar, this.description, this.createTime, this.status, this.countSV, this.listGroupMemberModel});

  GroupModel copyWith({
    int? id,
    String? classId,
    String? name,
    String? avatar,
    String? description,
    String? createTime,
    int? status,
    int? countSV,
  }) {
    return GroupModel(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      createTime: createTime ?? this.createTime,
      status: status ?? this.status,
      countSV: countSV ?? this.countSV,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'classId': classId,
      'name': name,
      'avatar': avatar,
      'description': description,
      'status': status,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] != null ? map['id'] as int : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      countSV: map['countSV'] != null ? map['countSV'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupModel(id: $id, classId: $classId, name: $name, avatar: $avatar, description: $description, createTime: $createTime, status: $status, countSV: $countSV)';
  }

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.classId == classId && other.name == name && other.avatar == avatar && other.description == description && other.createTime == createTime && other.status == status && other.countSV == countSV;
  }

  @override
  int get hashCode {
    return id.hashCode ^ classId.hashCode ^ name.hashCode ^ avatar.hashCode ^ description.hashCode ^ createTime.hashCode ^ status.hashCode ^ countSV.hashCode;
  }
}
