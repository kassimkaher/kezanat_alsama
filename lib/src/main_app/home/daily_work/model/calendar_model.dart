import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarModel {
  String? id;
  int? hijreeMonth;
  int? hijreeDay;
  int? meladyMonth;
  int? meladyDay;
  String? hijreeMonthName;
  DateTime? dateTime;
  String? hijreYear;
  DocumentReference<Map<String, dynamic>>? refrence;
  CalendarModel(
      {this.hijreeMonth,
      this.hijreeDay,
      this.meladyMonth,
      this.meladyDay,
      this.hijreeMonthName,
      this.dateTime,
      this.hijreYear,
      this.refrence,
      this.id});

  CalendarModel.fromJson(dynamic json) {
    try {
      id = json.id;
      refrence = json.reference;
    } catch (e) {}
    try {
      hijreeMonth = json['hijree_month'];

      hijreeDay = json['hijree_day'];

      meladyMonth = json['melady_month'];
      meladyDay = json['melady_day'];
      hijreeMonthName = json['hijree_month_name'];
      hijreYear = json['hijre_year'];
    } catch (e) {}

    try {
      dateTime = DateTime.tryParse(json['dateTime'].toString());
    } catch (_) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['hijree_month'] = hijreeMonth;
    data['hijree_day'] = hijreeDay;
    data['melady_month'] = meladyMonth;
    data['melady_day'] = meladyDay;
    data['hijree_month_name'] = hijreeMonthName;
    data['hijre_year'] = hijreYear;

    data['dateTime'] = dateTime.toString();
    data['id'] = id;
    return data;
  }
}
