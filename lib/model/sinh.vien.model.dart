// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class StudentModel {
  String? ma_sinh_vien;
  String? ho_lot;
  String? ten;
  String? ngay_sinh;
  String? ma_lop;
  String? ten_lop;
  String? dien_thoai;
  String? e_mail;
  StudentModel({
    this.ma_sinh_vien,
    this.ho_lot,
    this.ten,
    this.ngay_sinh,
    this.ma_lop,
    this.ten_lop,
    this.dien_thoai,
    this.e_mail,
  });

  StudentModel copyWith({
    String? ma_sinh_vien,
    String? ho_lot,
    String? ten,
    String? ngay_sinh,
    String? ma_lop,
    String? ten_lop,
    String? dien_thoai,
    String? e_mail,
  }) {
    return StudentModel(
      ma_sinh_vien: ma_sinh_vien ?? this.ma_sinh_vien,
      ho_lot: ho_lot ?? this.ho_lot,
      ten: ten ?? this.ten,
      ngay_sinh: ngay_sinh ?? this.ngay_sinh,
      ma_lop: ma_lop ?? this.ma_lop,
      ten_lop: ten_lop ?? this.ten_lop,
      dien_thoai: dien_thoai ?? this.dien_thoai,
      e_mail: e_mail ?? this.e_mail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ma_sinh_vien': ma_sinh_vien,
      'ho_lot': ho_lot,
      'ten': ten,
      'ngay_sinh': ngay_sinh,
      'ma_lop': ma_lop,
      'ten_lop': ten_lop,
      'dien_thoai': dien_thoai,
      'e_mail': e_mail,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      ma_sinh_vien: map['ma_sinh_vien'] != null ? map['ma_sinh_vien'] as String : null,
      ho_lot: map['ho_lot'] != null ? map['ho_lot'] as String : null,
      ten: map['ten'] != null ? map['ten'] as String : null,
      ngay_sinh: map['ngay_sinh'] != null ? map['ngay_sinh'] as String : null,
      ma_lop: map['ma_lop'] != null ? map['ma_lop'] as String : null,
      ten_lop: map['ten_lop'] != null ? map['ten_lop'] as String : null,
      dien_thoai: map['dien_thoai'] != null ? map['dien_thoai'] as String : null,
      e_mail: map['e_mail'] != null ? map['e_mail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) => StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentModel(ma_sinh_vien: $ma_sinh_vien, ho_lot: $ho_lot, ten: $ten, ngay_sinh: $ngay_sinh, ma_lop: $ma_lop, ten_lop: $ten_lop, dien_thoai: $dien_thoai, e_mail: $e_mail)';
  }

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.ma_sinh_vien == ma_sinh_vien &&
      other.ho_lot == ho_lot &&
      other.ten == ten &&
      other.ngay_sinh == ngay_sinh &&
      other.ma_lop == ma_lop &&
      other.ten_lop == ten_lop &&
      other.dien_thoai == dien_thoai &&
      other.e_mail == e_mail;
  }

  @override
  int get hashCode {
    return ma_sinh_vien.hashCode ^
      ho_lot.hashCode ^
      ten.hashCode ^
      ngay_sinh.hashCode ^
      ma_lop.hashCode ^
      ten_lop.hashCode ^
      dien_thoai.hashCode ^
      e_mail.hashCode;
  }
}
