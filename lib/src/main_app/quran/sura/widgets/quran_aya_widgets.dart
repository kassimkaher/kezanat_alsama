import 'package:ramadan/src/main_app/quran/data/model/quran_model.dart';
import 'package:ramadan/src/main_app/quran/widgets/component.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AyaSuraWidget extends StatelessWidget {
  const AyaSuraWidget(
      {super.key,
      required this.aya,
      required this.index,
      this.selectedAyah,
      required this.suraName});
  final Ayahs aya;
  final int index;
  final int? selectedAyah;
  final String suraName;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return VisibilityDetector(
      key: aya.key,
      onVisibilityChanged: (a) {},
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        dense: true,
        tileColor: aya.sajda != null
            ? theme.primaryColor.withOpacity(0.2)
            : Colors.transparent,
        title: aya.sajda != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Text(
                  aya.sajda!.obligatory == true ? "سجدة واجبة" : "سجدة مستحبة",
                  style: theme.textTheme.displaySmall,
                ),
              )
            : null,
        subtitle: InkWell(
          // onTap: () => showBottomSheet(
          //   shape: const RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(16),
          //           topRight: Radius.circular(16))),
          //   constraints: const BoxConstraints(minHeight: 250, maxHeight: 300),
          //   context: context,
          //   builder: (context) => BlocProvider(
          //     create: (context) =>
          //         getIt<QuranSoundCubit>()..playAya(aya.number ?? 0),
          //     child: AyahPlayerView(
          //         aya: AyahsJuzu(
          //             number: aya.number,
          //             surah: SurahInfo(name: suraName),
          //             text: aya.text),
          //         theme: theme),
          //   ),
          // ),
          // onLongPress: () =>
          // quranController.setContinu(
          //     suraName: data.name!,
          //     juzuNumber: data.ayahs,
          //     ayaIndex: i,
          //     number: data.ayahs!.length),
          child: Container(
              alignment: Alignment.centerRight,
              // margin: const EdgeInsets.symmetric(
              //     vertical: 12),
              // padding: const EdgeInsets.symmetric(
              //     horizontal: 12),
              // decoration: BoxDecoration(
              //     borderRadius:
              //         BorderRadius.circular(
              //             kDefaultBorderRadius),

              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: index == 0
                          ? aya.text
                          : aya.text!
                              .replaceFirst("بسم اللَّه الرحمن الرحيم", ""),
                      style: theme.textTheme.displayLarge!.copyWith(
                          height: 2,
                          backgroundColor: index == selectedAyah
                              ? theme.primaryColor.withOpacity(0.2)
                              : null),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            NumberWidget(
                              theme: theme,
                              size: 30,
                              number: (index + 1).toString(),
                            ),
                            const SizedBox(
                              height: 10,
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
