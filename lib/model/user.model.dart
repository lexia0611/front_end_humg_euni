// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? id;
  String? roles;
  String? name;
  String? username;
  String? accessToken;
  UserModel({
    this.id,
    this.roles,
    this.name,
    this.username,
    this.accessToken,
  });

  UserModel copyWith({
    String? id,
    String? roles,
    String? name,
    String? username,
    String? accessToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      roles: roles ?? this.roles,
      name: name ?? this.name,
      username: username ?? this.username,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'roles': roles,
      'name': name,
      'username': username,
      'accessToken': accessToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      roles: map['roles'] != null ? map['roles'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      username: map['userName'] != null ? map['userName'] as String : null,
      accessToken: map['access_token'] != null ? map['access_token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, roles: $roles, name: $name, username: $username, accessToken: $accessToken)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.roles == roles && other.name == name && other.username == username && other.accessToken == accessToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^ roles.hashCode ^ name.hashCode ^ username.hashCode ^ accessToken.hashCode;
  }
}
