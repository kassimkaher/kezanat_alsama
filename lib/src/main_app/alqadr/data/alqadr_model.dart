import 'package:ramadan/utils/utils.dart';

class AlqadrModel {
  DayDetails? day19;
  DayDetails? day21;
  DayDetails? day23;

  AlqadrModel({this.day19, this.day21, this.day23});

  AlqadrModel.fromJson(Map<String, dynamic> json) {
    try {
      day19 =
          json['day_19'] != null ? DayDetails.fromJson(json['day_19']) : null;
      day21 =
          json['day_21'] != null ? DayDetails.fromJson(json['day_21']) : null;
      day23 =
          json['day_23'] != null ? DayDetails.fromJson(json['day_23']) : null;
    } catch (e) {
      kdp(
          name: "alqadr json decode",
          msg: "error in get day details  $e ",
          c: 'r');
      // kdp(name: "alqadr json decode", msg: "${json} ", c: 'y');
    }
  }
}

class DayDetails {
  ItemData? other;
  ItemData? salatData;
  ItemData? zyaratData;
  ItemData? taspehData;
  ItemData? duaData;
  ItemData? quranAmal;
  ItemData? quranSuarData;

  DayDetails(
      {this.other,
      this.salatData,
      this.zyaratData,
      this.taspehData,
      this.duaData,
      this.quranAmal,
      this.quranSuarData});

  DayDetails.fromJson(Map<String, dynamic> json) {
    other = json['other'] != null ? ItemData.fromJson(json['other']) : null;
    salatData = json['salat_data'] != null
        ? ItemData.fromJson(json['salat_data'])
        : null;

    zyaratData = json['zyarat_data'] != null
        ? ItemData.fromJson(json['zyarat_data'])
        : null;
    taspehData = json['taspeh_data'] != null
        ? ItemData.fromJson(json['taspeh_data'])
        : null;
    duaData =
        json['dua_data'] != null ? ItemData.fromJson(json['dua_data']) : null;

    quranAmal = json['quran_amal'] != null
        ? ItemData.fromJson(json['quran_amal'])
        : null;
    quranSuarData = json['quran_suar_data'] != null
        ? ItemData.fromJson(json['quran_suar_data'])
        : null;
  }
}

class ItemData {
  String? title;
  String? desc;
  int? length;
  List<DataList>? dataList;

  ItemData({this.title, this.desc, this.length, this.dataList});

  ItemData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    length = json['length'];
    if (json['data_list'] != null) {
      dataList = <DataList>[];
      json['data_list'].forEach((v) {
        dataList!.add(DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['length'] = this.length;
    if (this.dataList != null) {
      data['data_list'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  String? title;
  String? smallText;
  String? bigText;
  String? image;
  String? type;
  bool? isBigText;
  int? index;
  String? desc;

  DataList(
      {this.title,
      this.smallText,
      this.bigText,
      this.image,
      this.type,
      this.isBigText,
      this.index,
      this.desc});

  DataList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    smallText = json['small_text'];
    bigText = json['big_text'];
    image = json['image'];
    type = json['type'];
    isBigText = json['is_big_text'];
    index = json['index'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['small_text'] = this.smallText;
    data['big_text'] = this.bigText;
    data['image'] = this.image;
    data['type'] = this.type;
    data['is_big_text'] = this.isBigText;
    data['index'] = this.index;
    data['desc'] = this.desc;
    return data;
  }
}
