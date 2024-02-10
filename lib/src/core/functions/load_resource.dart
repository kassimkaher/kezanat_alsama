import 'package:ramadan/utils/utils.dart';

Future<void> loadContent(
    String? path, Function(String? content) onComplete) async {
  if (path == null) {
    return;
  }
  try {
    final String response = await rootBundle.loadString('assets/docs/${path}');
    onComplete(response);
  } catch (e) {
    onComplete(null);
  }
}
