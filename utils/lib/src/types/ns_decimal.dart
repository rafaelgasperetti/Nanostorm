import 'dart:math';

import 'package:intl/intl.dart';

import 'package:utils/utils.dart';

class NSDecimal implements Comparable<num> {
  static const int _defaultCasasDecimais = 6;
  num value;
  int casasDecimais;

  NSDecimal({num n, NSDecimal decimal, casasDecimais = _defaultCasasDecimais}) :
        assert(((n != null && decimal == null) || (n == null && decimal != null)) && casasDecimais != null)
  {
    if(n != null) {
      this.value = n;
    } else {
      this.value = decimal.value;
    }

    if(casasDecimais == null) {
      casasDecimais = getCasasDecimais();
    }

    setCasasDecimais(casasDecimais);
  }

  static String _getThousandSeparator(String str) {
    String ret = StringUtils.emptyString();
    int start = 1;
    int tam = str.length;
    int idx = tam;

    while(idx > 0) {
      ret = str.substring(idx - 1, idx) + ret;
      if(start % 3 == 0) {
        ret = "," + ret;
        start = 1;
      } else {
        start++;
      }
      idx--;
    }

    return ret;
  }

  static NSDecimal getRandom({int max = 1000}) {
    return NSDecimal(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String getBaseFormat(String str, {String decimalSeparator, String prefixo, String sufixo, String separador = "", int casasDecimais}) {
    String formatoCompleto = StringUtils.emptyString();
    separador = StringUtils.isNull(separador) ? StringUtils.emptyString() : separador;

    if(!StringUtils.isNullOrEmpty(prefixo)) {
      String st1 = str.replaceAll(prefixo + separador, StringUtils.emptyString()).trim();
      String st2 = str.replaceAll(prefixo, StringUtils.emptyString()).trim();
      if(!str.startsWith(prefixo) || (str.startsWith(prefixo) && st1 == st2)) {
        prefixo = prefixo + separador;
      }
      str = str.replaceAll(prefixo, StringUtils.emptyString());
    }
    else {
      prefixo = StringUtils.emptyString();
    }
    if(!StringUtils.isNullOrEmpty(sufixo)) {
      String st1 = str.replaceAll(separador + sufixo, StringUtils.emptyString()).trim();
      String st2 = str.replaceAll(sufixo, StringUtils.emptyString()).trim();
      if(!str.endsWith(sufixo) || (str.endsWith(sufixo) && st1 == st2)) {
        sufixo = separador + sufixo;
      }
      str = str.replaceAll(sufixo, StringUtils.emptyString());
    }
    else {
      sufixo = StringUtils.emptyString();
    }

    int casasInteiras = str.contains(decimalSeparator) ? str.substring(0, str.lastIndexOf(decimalSeparator)).length : 0;
    casasDecimais = casasDecimais == null ? str.substring(str.lastIndexOf(decimalSeparator) + 1, str.length).length : casasDecimais;

    String exibicaoInteira = String.fromCharCodes(Iterable.generate(casasInteiras - 1, (e) => '#'.codeUnitAt(0))) + "0";
    String exibicaoDecimal = String.fromCharCodes(Iterable.generate(casasDecimais, (e) => '0'.codeUnitAt(0)));

    if(exibicaoDecimal.length == 0) {
      exibicaoDecimal = StringUtils.emptyString();
    }

    exibicaoInteira = _getThousandSeparator(exibicaoInteira);
    formatoCompleto += exibicaoInteira + (casasDecimais > 0 ? "." + exibicaoDecimal : StringUtils.emptyString());

    formatoCompleto = prefixo + formatoCompleto + sufixo;

    return formatoCompleto;
  }

  static NumberFormat getFormatter(String str, {String prefixo, String sufixo, String separador = "", int casasDecimais}) {
    String decimalSeparator = TypeUtils.getDecimalSeparator();

    if(str != null && !str.contains(TypeUtils.getDecimalSeparator())) {
      decimalSeparator = ".";
    }

    String base = getBaseFormat(str, decimalSeparator: decimalSeparator, prefixo: prefixo, sufixo: sufixo, separador: separador, casasDecimais: casasDecimais);
    NumberFormat formatter = NumberFormat(base, TypeUtils.getDefaultLocaleString());

    return formatter;
  }

  void setCasasDecimais(int casasDecimais) {
    if(casasDecimais < 0) {
      casasDecimais = 0;
    } else {
      this.casasDecimais = casasDecimais;
    }
  }

  bool operator ==(Object other) {
    if(other == null || this.value == null) {
      return false;
    }
    else if(other is num) {
      return this.value == other;
    }
    else if(other is NSDecimal) {
      return this.value == null || other.value == null ? false : this.value == other.value;
    } else {
      return false;
    }
  }

  bool operator <(Object other) {
    if(other == null) {
      return false;
    }
    else if(other is NSDecimal) {
      return this.value < other.value;
    }
    else if(other is num) {
      return this.value < other;
    }
    else {
      return false;
    }
  }
  
  bool operator <=(Object other) {
    if(other == null) {
      return false;
    }
    else if(other is NSDecimal) {
      return this.value <= other.value;
    }
    else if(other is num) {
      return this.value <= other;
    }
    else {
      return false;
    }
  }

  bool operator >(Object other) {
    if(other == null) {
      return false;
    }
    else if(other is NSDecimal) {
      return this.value > other.value;
    }
    else if(other is num) {
      return this.value > other;
    }
    else {
      return false;
    }
  }

  bool operator >=(Object other) {
    if(other == null) {
      return false;
    }
    else if(other is NSDecimal) {
      return this.value >= other.value;
    }
    else if(other is num) {
      return this.value >= other;
    }
    else {
      return false;
    }
  }

  NSDecimal operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value + other.value);
    }
    else if(other is num) {
      return NSDecimal(n: this.value + other);
    }
    else {
      return null;
    }
  }

  NSDecimal operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value - other.value);
    }
    else if(other is num) {
      return NSDecimal(n: this.value - other);
    }
    else {
      return null;
    }
  }

  NSDecimal operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value * other.value);
    }
    else if(other is num) {
      return NSDecimal(n: this.value * other);
    }
    else {
      return null;
    }
  }

  NSDecimal operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value / other.value);
    }
    else if(other is num) {
      return NSDecimal(n: this.value / other);
    }
    else {
      return null;
    }
  }

  NSDecimal operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSDecimal(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  NSDecimal operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value % other.value);
    }
    else if(other is num) {
      return NSDecimal(n: this.value % other);
    }
    else {
      return null;
    }
  }

  NSDecimal remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDecimal(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSDecimal(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  NSDecimal inc() {
    this.value++;
    return this;
  }

  NSDecimal dec() {
    this.value--;
    return this;
  }

  NSDecimal abs() {
    return this.value == null ? null : NSDecimal(n: this.value.abs());
  }

  @override
  String toString({String prefixo, String sufixo, separador: "", bool exibirPrefixoPadrao = true, bool exibirSufixoPadrao = true}) {
    separador = separador == null ? StringUtils.emptyString() : separador;
    prefixo = prefixo != null ? prefixo + separador : StringUtils.emptyString();
    sufixo = sufixo != null ? separador + sufixo : StringUtils.emptyString();
    return getFormatter(this.value.toString(), casasDecimais: casasDecimais, prefixo: prefixo, sufixo: sufixo).format(this.value);
  }

  static String toDefaultString() {
    return ZERO.toString();
  }

  NSDecimal get() {
    return this;
  }

  num getValue() {
    return this.value;
  }

  double getDouble() {
    return this.value as double;
  }

  int getInt() {
    return this.value as int;
  }

  @override
  int compareTo(num other) {
    if(this.value == null && other == null) {
      return 0;
    } else if(this.value == null && other != null) {
      return -1;
    } else if(this.value != null && other == null) {
      return 1;
    } else {
      return this.value.compareTo(other);
    }
  }

  int get hashCode {
    return value == null ? null : value.hashCode;
  }

  // ignore: non_constant_identifier_names
  static get ZERO {
    return NSDecimal(n: 0);
  }

  static get ONE {
    return NSDecimal(n: 1);
  }

  static String getPrefixo() {
    return null;
  }

  static String getSufixo() {
    return null;
  }

  static int getCasasDecimais() {
    return _defaultCasasDecimais;
  }

  static String getString(NSDecimal decimal, {Type type}) {
    if(decimal != null) {
      return decimal.toString();
    } else {
      if(type == NSMoney) {
        return NSMoney.toDefaultString();
      }
      else if(type == NSPrice) {
        return NSPrice.toDefaultString();
      }
      else if(type == NSPercent) {
        return NSDiscount.toDefaultString();
      }
      else if(type == NSDiscount) {
        return NSDiscount.toDefaultString();
      }
      else {
        return NSDecimal.toDefaultString();
      }
    }
  }

  static NSDecimal fromString(String value, {int casasDecimais, NumberFormat formatter, Type type, String prefixo, String sufixo}) {
    casasDecimais = casasDecimais == null ? getCasasDecimais() : casasDecimais;

    if(type == NSMoney) {
      return NSMoney.fromString(value, formatter: formatter);
    }
    else if(type == NSPrice) {
      return NSPrice.fromString(value, formatter: formatter);
    }
    if(type == NSDiscount) {
      return NSDiscount.fromString(value, formatter: formatter);
    }
    else if(type == NSPercent) {
      return NSPercent.fromString(value, formatter: formatter);
    }
    else if(type == NSWeight) {
      return NSWeight.fromString(value, formatter: formatter);
    }
    else if(type == NSQuantityWeight) {
      return NSQuantityWeight.fromString(value, formatter: formatter);
    }
    else {
      num val;

      if(formatter == null) {
        formatter = NSDecimal.getFormatter(value, casasDecimais: casasDecimais);
        if(value.contains(TypeUtils.getDecimalSeparator())) {
          val = formatter.parse(value);
        } else {
          val = num.parse(value);
        }
      }
      else {
        if(value.contains(TypeUtils.getDecimalSeparator())) {
          val = formatter.parse(value);
        } else {
          val = num.parse(value);
        }
      }

      return NSDecimal(n: val, casasDecimais: _defaultCasasDecimais);
    }
  }
}