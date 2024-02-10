import 'package:flutter/cupertino.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/utils/extention.dart';

class QuranJuzuModel {
  int? code;
  String? status;
  Data? data;

  QuranJuzuModel({code, status, data});

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
  List<Ayahs>? ayahs;
  List<SurahInfo>? surahsList;
  Edition? edition;
  List<QuranPages>? juzuPages;
  Data({number, ayahs, surahsList, edition});

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

        for (var page in pages) {
          final ayatOfPage =
              ayahs!.where((element) => element.page == page).toList();

          juzuPages!.add(QuranPages(
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
      {number,
      text,
      surah,
      numberInSurah,
      juz,
      manzil,
      page,
      ruku,
      hizbQuarter,
      sajda});

  Ayahs.fromJson(Map<String, dynamic> json, {bool? value}) {
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
      sajda = SajdaModel.fromJson(json['sajda']);
    } catch (_) {}
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
    data['sajda'] = sajda;
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
      {number,
      name,
      englishName,
      englishNameTranslation,
      revelationType,
      numberOfAyahs});

  SurahInfo.fromJson(Map<String, dynamic> json) {
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

  Edition({identifier, language, name, englishName, format, type, direction});

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
  List<Ayahs>? ayahs;

  QuranPages({ayahs, pageNumber, realPageNumber});
}
