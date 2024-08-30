
class StringUtils {

  static bool isEmpty(String? s) {
    return s == null || s.isEmpty;
  }

  static bool isNotEmpty(String? s) {
    return !isEmpty(s);
  }

}