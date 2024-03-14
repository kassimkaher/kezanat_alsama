import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/model/sura/sura_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';

part 'quran_sura_state.dart';
part 'quran_sura_cubit.freezed.dart';

class QuranSuraCubit extends Cubit<QuranSuraState> {
  QuranSuraCubit()
      : super(const QuranSuraState.initial(dataStatus: DataIdeal()));

  getQuranEvent(List<QuranJuzuModel> quranJuzu) async {
    emit(state.copyWith(dataStatus: const StateLoading()));

    final suraModel = SuraModel.fromSuraList(quranJuzu);
    // try {
    //   final String response =
    //       await rootBundle.loadString('assets/docs/quran.json');
    //   final jsondata = await json.decode(response);

    // emit(state.copyWith(
    //     quranModel: QuranModel.fromJson(jsondata),
    //     dataStatus: const SateSucess()));
    emit(state.copyWith(quranModel: suraModel, dataStatus: const SateSucess()));
    fillCache();
    // } catch (e) {
    //   log(e.toString());
    //   emit(state.copyWith(dataStatus: const StateError()));
    // }
  }

  searchInSura(String value) {
    if (value.isEmpty) {
      fillCache();
      return;
    }

    final data = state.cachQuranModelForSearch?.where(
        (sura) => normalise(sura.surahs.surahInfo.name!).contains(value));

    if (data != null && data.isNotEmpty) {
      emit(state.copyWith(cachQuranModelForSearch: data.toList()));

      return;
    }
    List<QuranSuraSearchItem> listsearch = [];
    state.quranModel?.forEach((element) {
      try {
        final ayahResult = element.ayaht.firstWhere((sura) {
          try {
            final normalize = normalise(sura.text!);

            if (normalize.contains(value)) {
//
              return true;
            }
            return false;
          } catch (e) {
            return false;
          }
        });

        listsearch.add(QuranSuraSearchItem(surahs: element, ayahs: ayahResult));
      } catch (_) {}
    });

    if (listsearch.isNotEmpty) {
      emit(state.copyWith(cachQuranModelForSearch: listsearch));
    }
  }

  // startReading() async {
  //   bool available = await state.info.speech.initialize(onStatus: (a) {
  //     kdp(name: "speach", msg: a, c: 'm');
  //   }, onError: (error) {
  //     kdp(name: "speach", msg: error, c: 'r');
  //   });
  //   if (available) {
  //     state.info.speech.listen(onResult: (a) {
  //       kdp(name: "speach", msg: a, c: 'gr');
  //     });
  //   } else {
  //     kdp(
  //         name: "speach",
  //         msg: "The user has denied the use of speech recognition.",
  //         c: 'y');
  //   }
  // some time later...
  //}

  void fillCache() {
    emit(state.copyWith(
        cachQuranModelForSearch: state.quranModel
            ?.map((e) => QuranSuraSearchItem(surahs: e))
            .toList()));
  }
}

String normalise(String input) => input
    .replaceAll('\u0610', '') //ARABIC SIGN SALLALLAHOU ALAYHE WA SALLAM
    .replaceAll('\u0611', '') //ARABIC SIGN ALAYHE ASSALLAM
    .replaceAll('\u0612', '') //ARABIC SIGN RAHMATULLAH ALAYHE
    .replaceAll('\u0613', '') //ARABIC SIGN RADI ALLAHOU ANHU
    .replaceAll('\u0614', '') //ARABIC SIGN TAKHALLUS

    //Remove koranic anotation
    .replaceAll('\u0615', '') //ARABIC SMALL HIGH TAH
    .replaceAll(
        '\u0616', '') //ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
    .replaceAll('\u0617', '') //ARABIC SMALL HIGH ZAIN
    .replaceAll('\u0618', '') //ARABIC SMALL FATHA
    .replaceAll('\u0619', '') //ARABIC SMALL DAMMA
    .replaceAll('\u061A', '') //ARABIC SMALL KASRA
    .replaceAll('\u06D6',
        '') //ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA
    .replaceAll('\u06D7',
        '') //ARABIC SMALL HIGH LIGATURE QAF WITH LAM WITH ALEF MAKSURA
    .replaceAll('\u06D8', '') //ARABIC SMALL HIGH MEEM INITIAL FORM
    .replaceAll('\u06D9', '') //ARABIC SMALL HIGH LAM ALEF
    .replaceAll('\u06DA', '') //ARABIC SMALL HIGH JEEM
    .replaceAll('\u06DB', '') //ARABIC SMALL HIGH THREE DOTS
    .replaceAll('\u06DC', '') //ARABIC SMALL HIGH SEEN
    .replaceAll('\u06DD', '') //ARABIC END OF AYAH
    .replaceAll('\u06DE', '') //ARABIC START OF RUB EL HIZB
    .replaceAll('\u06DF', '') //ARABIC SMALL HIGH ROUNDED ZERO
    .replaceAll('\u06E0', '') //ARABIC SMALL HIGH UPRIGHT RECTANGULAR ZERO
    .replaceAll('\u06E1', '') //ARABIC SMALL HIGH DOTLESS HEAD OF KHAH
    .replaceAll('\u06E2', '') //ARABIC SMALL HIGH MEEM ISOLATED FORM
    .replaceAll('\u06E3', '') //ARABIC SMALL LOW SEEN
    .replaceAll('\u06E4', '') //ARABIC SMALL HIGH MADDA
    .replaceAll('\u06E5', '') //ARABIC SMALL WAW
    .replaceAll('\u06E6', '') //ARABIC SMALL YEH
    .replaceAll('\u06E7', '') //ARABIC SMALL HIGH YEH
    .replaceAll('\u06E8', '') //ARABIC SMALL HIGH NOON
    .replaceAll('\u06E9', '') //ARABIC PLACE OF SAJDAH
    .replaceAll('\u06EA', '') //ARABIC EMPTY CENTRE LOW STOP
    .replaceAll('\u06EB', '') //ARABIC EMPTY CENTRE HIGH STOP
    .replaceAll('\u06EC', '') //ARABIC ROUNDED HIGH STOP WITH FILLED CENTRE
    .replaceAll('\u06ED', '') //ARABIC SMALL LOW MEEM

    //Remove tatweel
    .replaceAll('\u0640', '')

    //Remove tashkeel
    .replaceAll('\u064B', '') //ARABIC FATHATAN
    .replaceAll('\u064C', '') //ARABIC DAMMATAN
    .replaceAll('\u064D', '') //ARABIC KASRATAN
    .replaceAll('\u064E', '') //ARABIC FATHA
    .replaceAll('\u064F', '') //ARABIC DAMMA
    .replaceAll('\u0650', '') //ARABIC KASRA
    .replaceAll('\u0651', '') //ARABIC SHADDA
    .replaceAll('\u0652', '') //ARABIC SUKUN
    .replaceAll('\u0653', '') //ARABIC MADDAH ABOVE
    .replaceAll('\u0654', '') //ARABIC HAMZA ABOVE
    .replaceAll('\u0655', '') //ARABIC HAMZA BELOW
    .replaceAll('\u0656', '') //ARABIC SUBSCRIPT ALEF
    .replaceAll('\u0657', '') //ARABIC INVERTED DAMMA
    .replaceAll('\u0658', '') //ARABIC MARK NOON GHUNNA
    .replaceAll('\u0659', '') //ARABIC ZWARAKAY
    .replaceAll('\u065A', '') //ARABIC VOWEL SIGN SMALL V ABOVE
    .replaceAll('\u065B', '') //ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
    .replaceAll('\u065C', '') //ARABIC VOWEL SIGN DOT BELOW
    .replaceAll('\u065D', '') //ARABIC REVERSED DAMMA
    .replaceAll('\u065E', '') //ARABIC FATHA WITH TWO DOTS
    .replaceAll('\u065F', '')
    .replaceAll('\u0624', '\u0648')
    .replaceAll('\u0629', '\u0647')
    .replaceAll('\u0626', '\u0649')
    .replaceAll('\u0622', '\u0627')
    .replaceAll('\u0671', '\u0627')
    // .replaceAll('\u0656', '\u0627')
    // .replaceAll('\u0670', '\u0627')
    .replaceAll('\u0656', '')
    .replaceAll('\u0670', '')
    .replaceAll('\u0625', '\u0627');
