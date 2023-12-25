// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/model/assignment.student.model.dart';
class AssignmentModel {
  int? id;
  String? classId;
  String? title;
  String? description;
  String? fileName;
  String? createTime;
  String? dueDay;
  int? status;
  AssignmentStudentModel? assignmentStudentModel;
  AssignmentModel({
    this.id,
    this.classId,
    this.title,
    this.description,
    this.fileName,
    this.createTime,
    this.dueDay,
    this.status,
    this.assignmentStudentModel,
  });

  AssignmentModel copyWith({
    int? id,
    String? classId,
    String? title,
    String? description,
    String? fileName,
    String? createTime,
    String? dueDay,
    int? status,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      title: title ?? this.title,
      description: description ?? this.description,
      fileName: fileName ?? this.fileName,
      createTime: createTime ?? this.createTime,
      dueDay: dueDay ?? this.dueDay,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'classId': classId,
      'title': title,
      'description': description,
      'fileName': fileName,
      'dueDay': dueDay,
      'status': status,
    };
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'] != null ? map['id'] as int : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      dueDay: map['dueDay'] != null ? map['dueDay'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentModel.fromJson(String source) => AssignmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssignmentModel(id: $id, classId: $classId, title: $title, description: $description, fileName: $fileName, createTime: $createTime, dueDay: $dueDay, status: $status)';
  }

  @override
  bool operator ==(covariant AssignmentModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.classId == classId && other.title == title && other.description == description && other.fileName == fileName && other.createTime == createTime && other.dueDay == dueDay && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ classId.hashCode ^ title.hashCode ^ description.hashCode ^ fileName.hashCode ^ createTime.hashCode ^ dueDay.hashCode ^ status.hashCode;
  }
}
