import "dart:convert" show utf8;

class UnicodeHelper {
  static String cleanup(String string) {
    var utf8Runes = string.runes.toList();
    return utf8.decode(utf8Runes);
  }
}
