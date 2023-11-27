// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuizAnserModel {
  int? id;
  int? quizId;
  String? username;
  String? anser;
  List<int?> anserConvert;
  int? point;
  QuizAnserModel({
    this.id,
    this.quizId,
    this.username,
    this.anser,
    this.anserConvert = const [],
    this.point,
  });

  QuizAnserModel copyWith({
    int? id,
    int? quizId,
    String? username,
    String? anser,
    List<int?>? anserConvert,
    int? point,
  }) {
    return QuizAnserModel(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      username: username ?? this.username,
      anser: anser ?? this.anser,
      anserConvert: anserConvert ?? this.anserConvert,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quizId': quizId,
      'username': username,
      'anser': anser,
      'point': point,
    };
  }

  factory QuizAnserModel.fromMap(Map<String, dynamic> map) {
    return QuizAnserModel(
      id: map['id'] != null ? map['id'] as int : null,
      quizId: map['quizId'] != null ? map['quizId'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      anser: map['anser'] != null ? map['anser'] as String : null,
      point: map['point'] != null ? map['point'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizAnserModel.fromJson(String source) => QuizAnserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizAnserModel(id: $id, quizId: $quizId, username: $username, anser: $anser, anserConvert: $anserConvert, point: $point)';
  }

  @override
  bool operator ==(covariant QuizAnserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.quizId == quizId &&
      other.username == username &&
      other.anser == anser &&
      listEquals(other.anserConvert, anserConvert) &&
      other.point == point;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      quizId.hashCode ^
      username.hashCode ^
      anser.hashCode ^
      anserConvert.hashCode ^
      point.hashCode;
  }
}
