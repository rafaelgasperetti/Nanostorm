import 'dart:math';
import 'package:intl/intl.dart';

import 'package:utils/utils.dart';

class NSDiscount extends NSDecimal {

  NSDiscount({num n, NSDecimal decimal, int casasDecimais}) : super(n: n, decimal: decimal) {
    if(casasDecimais == null) {
      casasDecimais = getCasasDecimais();
    }

    setCasasDecimais(casasDecimais);
  }

  static NSDiscount getRandom({int max = 1000}) {
    return NSDiscount(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSDiscount(decimal: NSDecimal.ZERO).toString();
  }

  static String getSufixo() {
    return "%";
  }

  static int getCasasDecimais() {
    return 12;
  }

  @override
  // ignore: invalid_override_different_default_values_named
  String toString({String prefixo, String sufixo, separador: " ", bool exibirPrefixoPadrao = true, bool exibirSufixoPadrao = true}) {
    separador = separador == null ? StringUtils.emptyString() : separador;
    prefixo = prefixo != null ? prefixo + separador : StringUtils.emptyString();
    sufixo = (exibirSufixoPadrao ? getSufixo() : StringUtils.emptyString()) + (sufixo != null ? separador + sufixo : StringUtils.emptyString());
    return NSDecimal.getFormatter(this.value.toString(), prefixo: prefixo, sufixo: sufixo, casasDecimais: casasDecimais, separador: separador).format(this.value / 100);
  }

  static NSDiscount fromString(String value, {int casasDecimais, NumberFormat formatter}) {
    num val;
    casasDecimais = casasDecimais == null ? getCasasDecimais() : casasDecimais;

    String separador = " ";
    if(formatter == null) {
      formatter = NSDecimal.getFormatter(value, casasDecimais: casasDecimais, sufixo: getSufixo(), separador: separador);
      if(value.contains(TypeUtils.getDecimalSeparator())) {
        value = value.replaceAll(separador + getSufixo(), StringUtils.emptyString());
        val = formatter.parse(value);
      } else {
        val = num.parse(value);
      }
    }
    else {
      if(value.contains(TypeUtils.getDecimalSeparator())) {
        value = value.replaceAll(separador + getSufixo(), StringUtils.emptyString());
        val = formatter.parse(value);
      } else {
        val = num.parse(value);
      }
    }

    return NSDiscount(n: val * 100);
  }

  @override
  NSDiscount operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value + other.value);
    }
    else if(other is num) {
      return NSDiscount(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value - other.value);
    }
    else if(other is num) {
      return NSDiscount(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value * other.value);
    }
    else if(other is num) {
      return NSDiscount(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value / other.value);
    }
    else if(other is num) {
      return NSDiscount(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSDiscount(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value % other.value);
    }
    else if(other is num) {
      return NSDiscount(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSDiscount(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSDiscount(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSDiscount inc() {
    this.value++;
    return this;
  }

  @override
  NSDiscount dec() {
    this.value--;
    return this;
  }

  @override
  NSDiscount abs() {
    return this.value == null ? null : NSDiscount(n: this.value.abs());
  }
}