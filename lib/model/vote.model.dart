// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VoteModel {
  int? id;
  String? classId;
  String? createTime;
  String? title;
  int? status;
  VoteModel({
    this.id,
    this.classId,
    this.createTime,
    this.title,
    this.status,
  });

  VoteModel copyWith({
    int? id,
    String? classId,
    String? createTime,
    String? title,
    int? status,
  }) {
    return VoteModel(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      createTime: createTime ?? this.createTime,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'classId': classId,
      'title': title,
      'status': status,
    };
  }

  factory VoteModel.fromMap(Map<String, dynamic> map) {
    return VoteModel(
      id: map['id'] != null ? map['id'] as int : null,
      classId: map['classId'] != null ? map['classId'] as String : null,
      createTime: map['createTime'] != null ? map['createTime'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VoteModel.fromJson(String source) => VoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VoteModel(id: $id, classId: $classId, createTime: $createTime, title: $title, status: $status)';
  }

  @override
  bool operator ==(covariant VoteModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.classId == classId &&
      other.createTime == createTime &&
      other.title == title &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      classId.hashCode ^
      createTime.hashCode ^
      title.hashCode ^
      status.hashCode;
  }
}
