import 'dart:math';
import 'package:intl/intl.dart';
import 'package:utils/utils.dart';

import '../../utils.dart';

class NSMoney extends NSDecimal {

  NSMoney({num n, NSDecimal decimal, int casasDecimais}) : super(n: n, decimal: decimal) {
    if(casasDecimais == null) {
      casasDecimais = getCasasDecimais();
    }
    setCasasDecimais(casasDecimais);
  }

  static NSMoney getRandom({int max = 1000}) {
    return NSMoney(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  @override
  // ignore: invalid_override_different_default_values_named
  String toString({String prefixo, String sufixo, separador: " ", bool exibirPrefixoPadrao = true, bool exibirSufixoPadrao = true}) {
    separador = separador == null ? StringUtils.emptyString() : separador;
    prefixo = (prefixo == null ? StringUtils.emptyString() : prefixo + separador) + (exibirPrefixoPadrao ? getPrefixo() : StringUtils.emptyString());
    sufixo = sufixo != null ? separador + sufixo : StringUtils.emptyString();
    return NSDecimal.getFormatter(this.value.toString(), prefixo: prefixo, sufixo: sufixo, casasDecimais: casasDecimais, separador: separador).format(this.value);
  }

  static String toDefaultString() {
    return NSMoney(decimal: NSDecimal.ZERO).toString();
  }

  static String getPrefixo() {
    switch(TypeUtils.getDefaultCurrency()){
      case Currency.Dollar:
        return "U\$";
        break;
      case Currency.Peso:
        return "\$";
        break;
      default:
        return "R\$";
        break;
    }
  }

  static int getCasasDecimais() {
    return 4;
  }

  static NSMoney fromString(String value, {int casasDecimais, NumberFormat formatter}) {
    num val;
    casasDecimais = casasDecimais == null ? getCasasDecimais() : casasDecimais;

    if(formatter == null) {
      formatter = NSDecimal.getFormatter(value, casasDecimais: casasDecimais, prefixo: NSMoney.getPrefixo(), separador: " ");
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

    return NSMoney(n: val);
  }

  @override
  NSMoney operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value + other.value);
    }
    else if(other is num) {
      return NSMoney(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSMoney operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value - other.value);
    }
    else if(other is num) {
      return NSMoney(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSMoney operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value * other.value);
    }
    else if(other is num) {
      return NSMoney(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSMoney operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value / other.value);
    }
    else if(other is num) {
      return NSMoney(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSMoney operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSMoney(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSMoney operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value % other.value);
    }
    else if(other is num) {
      return NSMoney(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSMoney remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSMoney(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSMoney(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSMoney inc() {
    this.value++;
    return this;
  }

  @override
  NSMoney dec() {
    this.value--;
    return this;
  }

  @override
  NSMoney abs() {
    return this.value == null ? null : NSMoney(n: this.value.abs());
  }
}