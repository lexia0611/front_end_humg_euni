// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/model/sinh.vien.model.dart';

class AssignmentStudentModel {
  int? id;
  int? assignmentId;
  //maSV
  String? username;
  StudentModel? student;
  int? point;
  String? fileName;
  String? createTime;
  String? modifiedDate;
  AssignmentStudentModel({
    this.id,
    this.assignmentId,
    this.username,
    this.student,
    this.point,
    this.fileName,
    this.createTime,
    this.modifiedDate,
  });

  AssignmentStudentModel copyWith({
    int? id,
    int? assignmentId,
    String? username,
    StudentModel? student,
    int? point,
    String? fileName,
    String? createTime,
    String? modifiedDate,
  }) {
    return AssignmentStudentModel(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      username: username ?? this.username,
      student: student ?? this.student,
      point: point ?? this.point,
      fileName: fileName ?? this.fileName,
      createTime: createTime ?? this.createTime,
      modifiedDate: modifiedDate ?? this.modifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'assigmentId': assignmentId,
      'username': username,
      'student': student?.toMap(),
      'point': point,
      'fileName': fileName,
      'createTime': createTime,
      'modifiedDate': modifiedDate,
    };
  }

  factory AssignmentStudentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentStudentModel(
      id: map['id'] != null ? map['id'] as int : null,
      assignmentId: map['assigmentId'] != null ? map['assigmentId'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      student: map['student'] != null ? StudentModel.fromMap(map['student'] as Map<String,dynamic>) : null,
      point: map['point'] != null ? map['point'] as int : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      modifiedDate: map['modifiedDate'] != null ? map['modifiedDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentStudentModel.fromJson(String source) => AssignmentStudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssignmentStudentModel(id: $id, assigmentId: $assignmentId, username: $username, student: $student, point: $point, fileName: $fileName, createTime: $createTime, modifiedDate: $modifiedDate)';
  }

  @override
  bool operator ==(covariant AssignmentStudentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.assignmentId == assignmentId &&
      other.username == username &&
      other.student == student &&
      other.point == point &&
      other.fileName == fileName &&
      other.createTime == createTime &&
      other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      assignmentId.hashCode ^
      username.hashCode ^
      student.hashCode ^
      point.hashCode ^
      fileName.hashCode ^
      createTime.hashCode ^
      modifiedDate.hashCode;
  }
}
