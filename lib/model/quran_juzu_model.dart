import 'package:flutter/cupertino.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/utils/extention.dart';

class QuranJuzuModel {
  int? code;
  String? status;
  Data? data;

  QuranJuzuModel({this.code, this.status, this.data});

  QuranJuzuModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? number;
  List<Ayahs>? ayahs;
  List<SurahInfo>? surahsList;
  Edition? edition;
  List<QuranPages>? juzuPages;
  Data({this.number, this.ayahs, this.surahsList, this.edition});

  Data.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    if (json['ayahs'] != null) {
      ayahs = <Ayahs>[];
      json['ayahs'].forEach((v) {
        if (ayahs!.isEmpty) {
          ayahs!.add(Ayahs.fromJson(v, value: true));
        } else {
          final aya = Ayahs.fromJson(v);
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

        pages.forEach((page) {
          final ayatOfPage =
              ayahs!.where((element) => element.page == page).toList();

          juzuPages!.add(QuranPages(
              realPageNumber: page,
              pageNumber: pages.indexOf(page),
              ayahs: ayatOfPage));
        });
      } catch (e) {
        kdp(name: "quran pages converter", msg: e, c: 'r');
      }
    }
    if (json['surahs_list'] != null) {
      surahsList = <SurahInfo>[];
      json['surahs_list'].forEach((v) {
        surahsList!.add(new SurahInfo.fromJson(v));
      });
    }
    edition =
        json['edition'] != null ? new Edition.fromJson(json['edition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    if (this.ayahs != null) {
      data['ayahs'] = this.ayahs!.map((v) => v.toJson()).toList();
    }
    if (this.surahsList != null) {
      data['surahs_list'] = this.surahsList!.map((v) => v.toJson()).toList();
    }
    if (this.edition != null) {
      data['edition'] = this.edition!.toJson();
    }
    return data;
  }
}

class Ayahs {
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
  final key = GlobalKey();

  Ayahs(
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

  Ayahs.fromJson(Map<String, dynamic> json, {bool? value}) {
    isNew = value ?? false;
    number = json['number'];
    text = json['text'];
    surah =
        json['surah'] != null ? new SurahInfo.fromJson(json['surah']) : null;
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    try {
      sajda = SajdaModel.fromJson(json['sajda']);
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['text'] = this.text;
    if (this.surah != null) {
      data['surah'] = this.surah!.toJson();
    }
    data['numberInSurah'] = this.numberInSurah;
    data['juz'] = this.juz;
    data['manzil'] = this.manzil;
    data['page'] = this.page;
    data['ruku'] = this.ruku;
    data['hizbQuarter'] = this.hizbQuarter;
    data['sajda'] = this.sajda;
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

  SurahInfo.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['englishNameTranslation'] = this.englishNameTranslation;
    data['revelationType'] = this.revelationType;
    data['numberOfAyahs'] = this.numberOfAyahs;
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

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['language'] = this.language;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['format'] = this.format;
    data['type'] = this.type;
    data['direction'] = this.direction;
    return data;
  }
}

class QuranPages {
  int? pageNumber;
  int? realPageNumber;
  List<Ayahs>? ayahs;

  QuranPages({this.ayahs, this.pageNumber, this.realPageNumber});
}
