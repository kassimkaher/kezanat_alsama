import 'package:flutter/material.dart';
import 'package:ramadan/model/quran_juzu_model.dart';

class QuranModel {
  int? code;
  String? status;
  QuranData? data;

  QuranModel({this.code, this.status, this.data});

  QuranModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? QuranData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class QuranData {
  List<SuraOldMode>? surahs;
  Edition? edition;

  QuranData({this.surahs, this.edition});

  QuranData.fromJson(Map<String, dynamic> json) {
    if (json['surahs'] != null) {
      surahs = <SuraOldMode>[];
      json['surahs'].forEach((v) {
        surahs!.add(SuraOldMode.fromJson(v));
      });
    }
    edition =
        json['edition'] != null ? Edition.fromJson(json['edition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (surahs != null) {
      data['surahs'] = surahs!.map((v) => v.toJson()).toList();
    }
    if (edition != null) {
      data['edition'] = edition!.toJson();
    }
    return data;
  }
}

class SuraOldMode {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  List<Ayahs>? ayahs;

  SuraOldMode(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.ayahs});

  SuraOldMode.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];

    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    if (json['ayahs'] != null) {
      ayahs = <Ayahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add(Ayahs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['revelationType'] = revelationType;
    if (ayahs != null) {
      data['ayahs'] = ayahs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ayahs {
  int? number;
  String? text;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  SajdaModel? sajda;
  final key = GlobalKey();

  Ayahs(
      {this.number,
      this.text,
      this.numberInSurah,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.hizbQuarter,
      this.sajda});

  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
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

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;

  Edition(
      {this.identifier,
      this.language,
      this.name,
      this.englishName,
      this.format,
      this.type});

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['identifier'] = identifier;
    data['language'] = language;
    data['name'] = name;
    data['englishName'] = englishName;
    data['format'] = format;
    data['type'] = type;
    return data;
  }
}

class ContinuQuranModel {
  int? page;
  int? ayaNumber;
  String? nameSura;

  int? juzuNumber;

  ContinuQuranModel(
      {this.page, this.ayaNumber, this.nameSura, this.juzuNumber});

  ContinuQuranModel.fromJson(Map<dynamic, dynamic> json) {
    page = json['pageNumber'];
    ayaNumber = json['ayaNumber'];
    nameSura = json['name_sura'];

    juzuNumber = json['juzuNumber'];
  }

  int pageIndex(List<QuranPages> juzuPages) {
    final indexOfPage =
        juzuPages.indexWhere((element) => element.realPageNumber == page);

    return indexOfPage;
  }

  int ayaIndex(List<QuranPages> juzuPages) {
    final indexOfPage =
        juzuPages.indexWhere((element) => element.realPageNumber == page);

    final indexOfAya = juzuPages[indexOfPage]
        .ayahs!
        .indexWhere((element) => element.number == ayaNumber);
    return indexOfAya == -1 ? 0 : indexOfAya;
  }

  double pageNumber(List<QuranPages> juzuPages) {
    final indexOfPage =
        juzuPages.indexWhere((element) => element.realPageNumber == page);

    return indexOfPage / juzuPages.length;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pageNumber'] = page;
    data['ayaNumber'] = ayaNumber;
    data['name_sura'] = nameSura;

    data['juzuNumber'] = juzuNumber;

    return data;
  }
}

class SajdaModel {
  int? id;
  bool? recommended;
  bool? obligatory;

  SajdaModel({this.id, this.recommended, this.obligatory});

  SajdaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recommended = json['recommended'];
    obligatory = json['obligatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['recommended'] = recommended;
    data['obligatory'] = obligatory;
    return data;
  }
}
