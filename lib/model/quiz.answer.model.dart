// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuizAnswerModel {
  int? id;
  int? quizId;
  String? username;
  String? answer;
  List<int?> answerConvert;
  int? point;
  QuizAnswerModel({
    this.id,
    this.quizId,
    this.username,
    this.answer,
    this.answerConvert = const [],
    this.point,
  });

  QuizAnswerModel copyWith({
    int? id,
    int? quizId,
    String? username,
    String? answer,
    List<int?>? answerConvert,
    int? point,
  }) {
    return QuizAnswerModel(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      username: username ?? this.username,
      answer: answer ?? this.answer,
      answerConvert: answerConvert ?? this.answerConvert,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quizId': quizId,
      'username': username,
      'anser': answer,
      'point': point,
    };
  }

  factory QuizAnswerModel.fromMap(Map<String, dynamic> map) {
    return QuizAnswerModel(
      id: map['id'] != null ? map['id'] as int : null,
      quizId: map['quizId'] != null ? map['quizId'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      answer: map['anser'] != null ? map['anser'] as String : null,
      point: map['point'] != null ? map['point'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizAnswerModel.fromJson(String source) => QuizAnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizAnswerModel(id: $id, quizId: $quizId, username: $username, anser: $answer, anserConvert: $answerConvert, point: $point)';
  }

  @override
  bool operator ==(covariant QuizAnswerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.quizId == quizId &&
      other.username == username &&
      other.answer == answer &&
      listEquals(other.answerConvert, answerConvert) &&
      other.point == point;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      quizId.hashCode ^
      username.hashCode ^
      answer.hashCode ^
      answerConvert.hashCode ^
      point.hashCode;
  }
}
