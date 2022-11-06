import 'dart:math';

class StringUtil {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String random(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String formatDate(final DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  /// Hash the given [text]
  static int hash(final String text) {
    var hash = 0;
    for (var i = 0; i < text.length; ++i) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    return hash;
  }
}
