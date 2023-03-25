import 'package:ramadan/model/ramadan_dua.dart';

class RamadanAmalModel {
  List<TodayPrayer>? ramadan;

  RamadanAmalModel({this.ramadan});

  RamadanAmalModel.fromJson(Map<String, dynamic> json) {
    if (json['ramadan'] != null) {
      ramadan = <TodayPrayer>[];
      json['ramadan'].forEach((v) {
        ramadan!.add(new TodayPrayer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ramadan != null) {
      data['ramadan'] = this.ramadan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayPrayer {
  int? day;
  List<Dua>? amaoOfToday;

  TodayPrayer({this.day, this.amaoOfToday});

  TodayPrayer.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['amao_of_today'] != null) {
      amaoOfToday = [];
      json['amao_of_today'].forEach((v) {
        amaoOfToday!.add(new Dua.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.amaoOfToday != null) {
      data['amao_of_today'] = this.amaoOfToday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
