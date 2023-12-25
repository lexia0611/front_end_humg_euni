// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/model/quiz.answer.model.dart';

class QuizModel {
  int? id;
  String? classId;
  String? title;
  String? startTime;
  String? endTime;
  String? createTime;
  int? status;
  QuizAnswerModel? quizAnswerModel;
  QuizModel({
    this.id,
    this.classId,
    this.title,
    this.startTime,
    this.endTime,
    this.createTime,
    this.status,
    this.quizAnswerModel,
  });

  QuizModel copyWith({
    int? id,
    String? classId,
    String? title,
    String? startTime,
    String? endTime,
    String? createTime,
    int? status,
  }) {
    return QuizModel(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createTime: createTime ?? this.createTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'classId': classId,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'createTime': createTime,
      'status': status,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map['id'] != null ? map['id'] as int : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizModel(id: $id, classId: $classId, title: $title, startTime: $startTime, endTime: $endTime, createTime: $createTime, status: $status)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.classId == classId && other.title == title && other.startTime == startTime && other.endTime == endTime && other.createTime == createTime && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ classId.hashCode ^ title.hashCode ^ startTime.hashCode ^ endTime.hashCode ^ createTime.hashCode ^ status.hashCode;
  }
}
