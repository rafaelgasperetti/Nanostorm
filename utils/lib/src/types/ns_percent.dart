import 'dart:math';
import 'package:intl/intl.dart';
import 'package:utils/utils.dart';

class NSPercent extends NSDiscount {

  NSPercent({num n, NSDecimal decimal}) : super(n: n, decimal: decimal) {
    setCasasDecimais(getCasasDecimais());
  }

  static NSPercent getRandom({int max = 1000}) {
    return NSPercent(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSPercent(decimal: NSDecimal.ZERO).toString();
  }

  static int getCasasDecimais() {
    return 2;
  }

  static NSPercent fromString(String value, {NumberFormat formatter}) {
    return NSPercent(decimal: NSDiscount.fromString(value, formatter: formatter, casasDecimais: getCasasDecimais()));
  }

  @override
  NSPercent operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value + other.value);
    }
    else if(other is num) {
      return NSPercent(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSPercent operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value - other.value);
    }
    else if(other is num) {
      return NSPercent(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSPercent operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value * other.value);
    }
    else if(other is num) {
      return NSPercent(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSPercent operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value / other.value);
    }
    else if(other is num) {
      return NSPercent(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSPercent operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSPercent(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSPercent operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value % other.value);
    }
    else if(other is num) {
      return NSPercent(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSPercent remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPercent(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSPercent(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSPercent inc() {
    this.value++;
    return this;
  }

  @override
  NSPercent dec() {
    this.value--;
    return this;
  }

  @override
  NSPercent abs() {
    return this.value == null ? null : NSPercent(n: this.value.abs());
  }
}