import 'dart:math';
import 'package:utils/utils.dart';
import 'package:intl/intl.dart';

class NSWeight extends NSDecimal {

  NSWeight({num n, NSDecimal decimal, int casasDecimais}) : super(n: n, decimal: decimal) {
    if(casasDecimais == null) {
      casasDecimais = getCasasDecimais();
    }

    setCasasDecimais(casasDecimais);
  }

  static NSWeight getRandom({int max = 1000}) {
    return NSWeight(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSWeight(decimal: NSDecimal.ZERO).toString();
  }

  static String getSufixo() {
    switch(TypeUtils.getDefaultWeight()) {
      case Weight.Lb:
        return "lb";
        break;
      default:
        return "Kg";
        break;
    }
  }

  static int getCasasDecimais() {
    return 2;
  }

  @override
  // ignore: invalid_override_different_default_values_named
  String toString({String prefixo, String sufixo, separador: " ", bool exibirPrefixoPadrao = true, bool exibirSufixoPadrao = true}) {
    separador = separador == null ? StringUtils.emptyString() : separador;
    prefixo = prefixo != null ? prefixo + separador : StringUtils.emptyString();
    sufixo = (exibirSufixoPadrao ? getSufixo() : StringUtils.emptyString()) + (sufixo != null ? separador + sufixo : StringUtils.emptyString());
    return NSDecimal.getFormatter(this.value.toString(), prefixo: prefixo, sufixo: sufixo, casasDecimais: casasDecimais, separador: separador).format(this.value);
  }

  static NSWeight fromString(String value, {int casasDecimais, NumberFormat formatter}) {
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

    return NSWeight(n: val);
  }

  @override
  NSWeight operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value + other.value);
    }
    else if(other is num) {
      return NSWeight(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSWeight operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value - other.value);
    }
    else if(other is num) {
      return NSWeight(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSWeight operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value * other.value);
    }
    else if(other is num) {
      return NSWeight(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSWeight operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value / other.value);
    }
    else if(other is num) {
      return NSWeight(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSWeight operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSWeight(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSWeight operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value % other.value);
    }
    else if(other is num) {
      return NSWeight(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSWeight remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSWeight(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSWeight(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSWeight inc() {
    this.value++;
    return this;
  }

  @override
  NSWeight dec() {
    this.value--;
    return this;
  }

  @override
  NSWeight abs() {
    return this.value == null ? null : NSWeight(n: this.value.abs());
  }
}