class StringUtils {
  static String emptyString() {
    return '';
  }

  static String spaceString() {
    return ' ';
  }

  static String tabString() {
    return '  ';
  }

  static String newLineString() {
    return '\n';
  }

  static String clString() {
    return '\r';
  }

  static String credenctialSeparator() {
    return '@';
  }

  static String join(List<String> strings, String separator) {
    if (strings == null || strings.isEmpty) {
      return emptyString();
    }

    separator =
        StringUtils.isNullOrEmpty(separator) ? emptyString() : separator;

    String result = emptyString();

    for (String s in strings) {
      if (!StringUtils.isNullOrEmpty(s)) {
        result +=
            (StringUtils.isNullOrEmpty(result) ? emptyString() : separator) + s;
      }
    }

    return result;
  }

  static bool isNull(String str) {
    return str == null;
  }

  static bool isNullOrEmpty(String str) {
    return isNull(str) || str == emptyString();
  }

  static bool isNullOrEmptyWS(String str) {
    return isNull(str) || str.trim() == emptyString();
  }

  static String fullStringTrim(String str) {
    if (str == null) {
      return null;
    }
    return str
        .trim()
        .replaceAll(spaceString(), emptyString())
        .replaceAll(tabString(), emptyString())
        .replaceAll(clString(), emptyString())
        .replaceAll(newLineString(), emptyString());
  }

  static bool equalsIgnoreSpace(String str, String str2) {
    return !isNull(str) &&
        !isNull(str2) &&
        fullStringTrim(str) == fullStringTrim(str2);
  }

  static String obscureEmail(String email) {
    if (!isNullOrEmpty(email) && email.contains('@')) {
      String prefixo = email.substring(0, email.indexOf('@'));
      String sufixo = email.substring(email.indexOf('@') + 1, email.length);
      prefixo = prefixo.replaceRange(
          prefixo.length ~/ 3, prefixo.length, '**********');
      sufixo =
          sufixo.replaceRange(sufixo.indexOf('.'), sufixo.length, '******');
      return prefixo + '@' + sufixo;
    }
    return email;
  }
}
