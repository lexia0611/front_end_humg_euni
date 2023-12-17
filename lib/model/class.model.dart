// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassModel {
  String? id;
  String? tenMon;
  String? nhomTo;
  String? tkb;
  String? tuGio;
  String? denGio;
  String? gv;
  String? phong;

  ClassModel({
    this.id,
    this.tenMon,
    this.nhomTo,
    this.tkb,
    this.tuGio,
    this.denGio,
    this.gv,
    this.phong,
  });

  ClassModel copyWith({
    String? id,
    String? tenMon,
    String? nhomTo,
    String? tkb,
    String? tuGio,
    String? denGio,
    String? gv,
    String? phong,
    int? countSinhVien,
  }) {
    return ClassModel(
      id: id ?? this.id,
      tenMon: tenMon ?? this.tenMon,
      nhomTo: nhomTo ?? this.nhomTo,
      tkb: tkb ?? this.tkb,
      tuGio: tuGio ?? this.tuGio,
      denGio: denGio ?? this.denGio,
      gv: gv ?? this.gv,
      phong: phong ?? this.phong,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tenMon': tenMon,
      'nhomTo': nhomTo,
      'tkb': tkb,
      'tuGio': tuGio,
      'denGio': denGio,
      'gv': gv,
      'phong': phong,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id_to_hoc'] != null ? map['id_to_hoc'] as String : null,
      tenMon: map['ten_mon'] != null ? map['ten_mon'] as String : null,
      nhomTo: map['nhom_to'] != null ? map['nhom_to'] as String : null,
      tkb: map['tkb'] != null ? map['tkb'] as String : null,
      tuGio: map['tu_gio'] != null ? map['tu_gio'] as String : null,
      denGio: map['den_gio'] != null ? map['den_gio'] as String : null,
      gv: map['gv'] != null ? map['gv'] as String : null,
      phong: map['phong'] != null ? map['phong'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) => ClassModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassModel(id: $id, tenMon: $tenMon, nhomTo: $nhomTo, tkb: $tkb, tuGio: $tuGio, denGio: $denGio, gv: $gv, phong: $phong)';
  }
}
