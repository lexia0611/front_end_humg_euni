// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VoteOptionModel {
  int? id;
  int? voteId;
  String? title;
  String? data;
  int? count;
  VoteOptionModel({
    this.id,
    this.voteId,
    this.title,
    this.data,
    this.count,
  });

  VoteOptionModel copyWith({
    int? id,
    int? voteId,
    String? title,
    String? data,
  }) {
    return VoteOptionModel(
      id: id ?? this.id,
      voteId: voteId ?? this.voteId,
      title: title ?? this.title,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'voteId': voteId,
      'title': title,
      'data': data,
    };
  }

  factory VoteOptionModel.fromMap(Map<String, dynamic> map) {
    return VoteOptionModel(
      id: map['id'] != null ? map['id'] as int : null,
      voteId: map['voteId'] != null ? map['voteId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      data: map['data'] != null ? map['data'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VoteOptionModel.fromJson(String source) => VoteOptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VoteOptionModel(id: $id, voteId: $voteId, title: $title, data: $data)';
  }

  @override
  bool operator ==(covariant VoteOptionModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.voteId == voteId && other.title == title && other.data == data;
  }

  @override
  int get hashCode {
    return id.hashCode ^ voteId.hashCode ^ title.hashCode ^ data.hashCode;
  }
}
