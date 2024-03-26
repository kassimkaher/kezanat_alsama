import 'package:ramadan/model/ramadan_dua.dart';

class WorksDocumentModel {
  List<DuaEntity>? zyaratList;
  List<DuaEntity>? munajatList;
  List<DuaEntity>? dua;

  WorksDocumentModel({this.zyaratList, this.munajatList});

  WorksDocumentModel.fromJson(Map<String, dynamic> json) {
    if (json['dua_list'] != null) {
      dua = <DuaEntity>[];
      json['dua_list'].forEach((v) {
        dua!.add(DuaEntity.fromJson(v));
      });
    }
    if (json['zyarat_list'] != null) {
      zyaratList = <DuaEntity>[];
      json['zyarat_list'].forEach((v) {
        zyaratList!.add(DuaEntity.fromJson(v));
      });
    }
    if (json['munajat_list'] != null) {
      munajatList = <DuaEntity>[];
      json['munajat_list'].forEach((v) {
        munajatList!.add(DuaEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zyaratList != null) {
      data['zyarat_list'] = this.zyaratList!.map((v) => v.toJson()).toList();
    }
    if (this.munajatList != null) {
      data['munajat_list'] = this.munajatList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
