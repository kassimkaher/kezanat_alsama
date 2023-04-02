import 'package:ramadan/model/ramadan_dua.dart';

class ZyaratMunajatModel {
  List<Dua>? zyaratList;
  List<Dua>? munajatList;

  ZyaratMunajatModel({this.zyaratList, this.munajatList});

  ZyaratMunajatModel.fromJson(Map<String, dynamic> json) {
    if (json['zyarat_list'] != null) {
      zyaratList = <Dua>[];
      json['zyarat_list'].forEach((v) {
        zyaratList!.add(new Dua.fromJson(v));
      });
    }
    if (json['munajat_list'] != null) {
      munajatList = <Dua>[];
      json['munajat_list'].forEach((v) {
        munajatList!.add(new Dua.fromJson(v));
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
