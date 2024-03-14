import 'package:ramadan/model/quran_juzu_model.dart';

import 'package:collection/collection.dart';

class SuraModel {
  List<AyahsJuzu> ayaht;
  SurahInfo surahInfo;
  SuraModel(this.ayaht, this.surahInfo);

  static List<SuraModel> fromSuraList(List<QuranJuzuModel> juzu) {
    List<SuraModel> list = [];

    final ayahs = juzu
        .map((e) => e.data?.ayahs)
        .toList()
        .expand((innerList) => innerList!.toList())
        .toList();
    final listSura = groupBy(ayahs, (item) => item.surah!.name);
    // for (var i = 1; i < 114; i++) {

    //   final listsura = ayahs.where((e) => e.surah!.number == i).toList();
    //   list.add(SuraModel(listsura, ayahs.first.surah!));
    // }

    for (var element in listSura.entries) {
      list.add(SuraModel(element.value, element.value.first.surah!));
    }

    return list;
  }
}
