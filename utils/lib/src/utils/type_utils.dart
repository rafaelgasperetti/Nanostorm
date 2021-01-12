import 'package:flutter/widgets.dart';

import 'package:utils/utils.dart';
import 'package:flutter/rendering.dart';

enum Currency {
  Real,
  Dollar,
  Peso
}

enum Weight {
  Kg,
  Lb
}

class TypeUtils {
  static const String language_pt = "pt";
  static const String language_es = "es";
  static const String language_en = "en";

  static const String country_br = "BR";
  static const String country_mx = "MX";
  static const String country_us = "US";

  static const String code_pt_br = language_pt + "_" + country_br;
  static const String code_es_mx = language_es + "_" + country_mx;
  static const String code_en_us = language_en + "_" + country_us;

  static final Locale pt_br = TypeUtils.fromCodes(language_pt, country_br);//Português Brasileiro
  static final Locale es_mx = TypeUtils.fromCodes(language_es, country_mx);//Espanhol Mexicano
  static final Locale en_us = TypeUtils.fromCodes(language_en, country_us);//Inglês Americano

  static String fromLanguageCountryCode(String languageCode, String coutryCode) {
    if(languageCode == null || coutryCode == null) {
      return null;
    }

    return languageCode + "_" + coutryCode;
  }

  static String fromLocale(Locale locale) {
    if(locale == null) {
      return null;
    }

    return fromLanguageCountryCode(locale.languageCode, locale.countryCode);
  }

  static Locale fromCodes(String languageCode, String countryCode) {
    return Locale.fromSubtags(languageCode: languageCode, countryCode: countryCode);
  }

  static Locale getDefaultLocale() {
    return pt_br;
  }

  static String getDefaultLocaleString() {
    return fromLocale(getDefaultLocale());
  }

  static Future initializeFormats() {
    return NSDateTime.initFormats();
  }

  static String getDecimalSeparator() {
    switch(getDefaultLocaleString()) {
      case code_en_us:
        return ".";
      default:
        return ",";
    }
  }

  static String getThousandSeparator() {
    switch(getDefaultLocaleString()) {
      case code_en_us:
        return ",";
      default:
        return ".";
    }
  }

  static Currency getDefaultCurrency() {
    switch(getDefaultLocaleString()) {
      case code_en_us:
        return Currency.Dollar;
      case code_es_mx:
        return Currency.Peso;
      default:
        return Currency.Real;
    }
  }

  static Weight getDefaultWeight() {
    switch(getDefaultLocaleString()) {
      case code_en_us:
        return Weight.Lb;
      default:
        return Weight.Kg;
    }
  }
}