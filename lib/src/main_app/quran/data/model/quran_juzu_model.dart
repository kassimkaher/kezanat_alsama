import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramadan/src/main_app/quran/data/model/quran_model.dart';
import 'package:ramadan/utils/extention.dart';

class QuranJuzuModel {
  int? code;
  String? status;
  Data? data;

  QuranJuzuModel({this.code, this.status, this.data});

  QuranJuzuModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = {};
    data1['code'] = code;
    data1['status'] = status;
    if (data != null) {
      data1['data'] = data!.toJson();
    }
    return data1;
  }
}

class Data {
  int? number;
  List<AyahsJuzu>? ayahs;
  List<SurahInfo>? surahsList;
  Edition? edition;
  late List<QuranPages> juzuPages;

  Data(
      {this.number,
      this.ayahs,
      this.surahsList,
      this.edition,
      required this.juzuPages});

  Data.fromJson(Map<dynamic, dynamic> json) {
    number = json['number'];
    if (json['ayahs'] != null) {
      ayahs = <AyahsJuzu>[];
      json['ayahs'].forEach((v) {
        if (ayahs!.isEmpty) {
          ayahs!.add(AyahsJuzu.fromJson(v, value: true));
        } else {
          final aya = AyahsJuzu.fromJson(v);
          if (ayahs![ayahs!.length - 1].surah!.englishName !=
              aya.surah!.englishName) {
            aya.isNew = true;
          }

          ayahs!.add(aya);
        }
      });

      try {
        juzuPages = [];
        final pages = ayahs!.asMap().values.map((e) => e.page).toSet().toList();

        for (var page in pages) {
          final ayatOfPage =
              ayahs!.where((element) => element.page == page).toList();

          juzuPages.add(QuranPages(
              realPageNumber: page,
              pageNumber: pages.indexOf(page),
              ayahs: ayatOfPage));
        }
      } catch (e) {
        kdp(name: "quran pages converter", msg: e, c: 'r');
      }
    }
    if (json['surahs_list'] != null) {
      surahsList = <SurahInfo>[];
      json['surahs_list'].forEach((v) {
        surahsList!.add(SurahInfo.fromJson(v));
      });
    }
    edition =
        json['edition'] != null ? Edition.fromJson(json['edition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    if (ayahs != null) {
      data['ayahs'] = ayahs!.map((v) => v.toJson()).toList();
    }
    if (surahsList != null) {
      data['surahs_list'] = surahsList!.map((v) => v.toJson()).toList();
    }
    if (edition != null) {
      data['edition'] = edition!.toJson();
    }
    return data;
  }
}

class AyahsJuzu {
  int? number;
  String? text;
  SurahInfo? surah;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  SajdaModel? sajda;
  bool isNew = false;
  Widget? book ;
  final key = GlobalKey();

  AyahsJuzu(
      {this.number,
      this.text,
      this.surah,
      this.numberInSurah,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.hizbQuarter,
      this.sajda});

  AyahsJuzu.fromJson(Map<dynamic, dynamic> json, {bool? value}) {
    isNew = value ?? false;
    number = json['number'];
    text = json['text'];
    surah = json['surah'] != null ? SurahInfo.fromJson(json['surah']) : null;
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    try {
      sajda = json['sajda'] == null ? null : SajdaModel.fromJson(json['sajda']);
    } catch (e) {
      kdp(name: "sajda", msg: e, c: 'r');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['text'] = text;
    if (surah != null) {
      data['surah'] = surah!.toJson();
    }
    data['numberInSurah'] = numberInSurah;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['page'] = page;
    data['ruku'] = ruku;
    data['hizbQuarter'] = hizbQuarter;
    data['sajda'] = sajda?.toJson();
    return data;
  }
}

class SurahInfo {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  int? numberOfAyahs;

  SurahInfo(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.numberOfAyahs});

  SurahInfo.fromJson(Map<dynamic, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['revelationType'] = revelationType;
    data['numberOfAyahs'] = numberOfAyahs;
    return data;
  }
}

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
  String? direction;

  Edition(
      {this.identifier,
      this.language,
      this.name,
      this.englishName,
      this.format,
      this.type,
      this.direction});

  Edition.fromJson(Map<dynamic, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['identifier'] = identifier;
    data['language'] = language;
    data['name'] = name;
    data['englishName'] = englishName;
    data['format'] = format;
    data['type'] = type;
    data['direction'] = direction;
    return data;
  }
}

class QuranPages {
  int? pageNumber;
  int? realPageNumber;
  List<AyahsJuzu>? ayahs;

  QuranPages({this.ayahs, this.pageNumber, this.realPageNumber});
}
