import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/src/core/enum/week_day.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/core/enum/work_type.dart';

class DailyWorkModel {
  List<DailyWorkData>? data;
  DateTime? dateTime;
  DailyWorkModel({this.data, this.dateTime});
  DailyWorkModel.fromJson(dynamic json) {
    try {
      dateTime = DateTime.tryParse(json['dateTime'].toString());
    } catch (_) {}
    data = [];
    try {
      json['data'].forEach((e) => data!.add(DailyWorkData.fromJson(e)));
    } catch (_) {}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    List<Map<dynamic, dynamic>> datajson = [];
    data?.forEach((e) => datajson.add(e.toJson()));
    json['dateTime'] = dateTime;
    json['data'] = datajson;

    return json;
  }
}

class DailyWorkData {
  String? id;
  String? url;
  int? day;
  String? title;
  int? month;
  String? text;
  String? path;
  String? description;
  int? sura;
  WorkType? type;
  WeekDay? weekDay;
  int? hour;
  // isRequired = false=> meaan if there is an work not assoseated with any date or arabic month
  bool? isRequired;
  WorkTiming? workTiming;
  DailyWorkData(
      {this.url,
      this.day,
      this.title,
      this.month,
      this.text,
      this.path,
      this.description,
      this.sura,
      this.type,
      this.weekDay,
      this.hour,
      this.id,
      this.isRequired,
      this.workTiming});

  DailyWorkData.fromJson(
    dynamic json,
  ) {
    id = json['id'];
    url = json['url'];
    day = json['day'];
    title = json['title'];
    month = json['month'];
    text = json['text'];
    path = json['path'];
    description = json['description'];
    sura = json['sura'];

    hour = json['hour'];
    isRequired = json['isRequired'];

    if (json['week_day'] != null && json['week_day'].toString().isNotEmpty) {
      weekDay = WeekDay.values.byName(json['week_day']);
    }
    if (json['type'] != null) {
      type = WorkType.values.byName(json['type']);
    }
    if (json['workTiming'] != null) {
      workTiming = WorkTiming.values.byName(json['workTiming']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['day'] = this.day;
    data['title'] = this.title;
    data['month'] = this.month;
    data['text'] = this.text;
    data['path'] = this.path;
    data['description'] = this.description;
    data['sura'] = this.sura;
    data['type'] = this.type?.name;
    data['week_day'] = weekDay?.name;
    data['hour'] = hour;
    data['isRequired'] = isRequired;
    data['workTiming'] = workTiming?.name;
    return data;
  }

  toDuaEntity() {
    return DuaEntity(
        title: title,
        desc: description,
        text: text,
        path: path,
        type: type?.name ?? "");
  }
}
