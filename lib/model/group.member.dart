// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/model/sinh.vien.model.dart';

class GroupMemberModel {
  int? id;
  int? groupId;
  String? username;
  StudentModel? student;
  GroupMemberModel({
    this.id,
    this.groupId,
    this.username,
    this.student,
  });

  GroupMemberModel copyWith({
    int? id,
    int? groupId,
    String? username,
  }) {
    return GroupMemberModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'groupId': groupId,
      'username': username,
    };
  }

  factory GroupMemberModel.fromMap(Map<String, dynamic> map) {
    return GroupMemberModel(
      id: map['id'] != null ? map['id'] as int : null,
      groupId: map['groupId'] != null ? map['groupId'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupMemberModel.fromJson(String source) => GroupMemberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GroupMemberModel(id: $id, groupId: $groupId, username: $username)';

  @override
  bool operator ==(covariant GroupMemberModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.groupId == groupId && other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ groupId.hashCode ^ username.hashCode;
}
