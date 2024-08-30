
class FrpLogUtils {

  static String removeColorTags(String text) {
    String colorCodePattern = '\u001b\\[[\\d;]+m';
    RegExp regex = RegExp(colorCodePattern);
    return text.replaceAll(regex, '');
  }

}