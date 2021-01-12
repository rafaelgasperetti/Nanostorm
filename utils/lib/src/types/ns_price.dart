import 'dart:math';
import 'package:utils/utils.dart';
import 'package:intl/intl.dart';

class NSPrice extends NSMoney {
  NSPrice({num n, NSDecimal decimal}) : super(n: n, decimal: decimal) {
    setCasasDecimais(getCasasDecimais());
  }

  static NSPrice getRandom({int max = 1000}) {
    return NSPrice(
        n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSPrice(decimal: NSDecimal.ZERO).toString();
  }

  static int getCasasDecimais() {
    return 2;
  }

  static NSPrice fromString(String value, {NumberFormat formatter}) {
    return NSPrice(
        decimal: NSMoney.fromString(value,
            formatter: formatter, casasDecimais: getCasasDecimais()));
  }

  @override
  NSPrice operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value + other.value);
    }
    else if(other is num) {
      return NSPrice(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSPrice operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value - other.value);
    }
    else if(other is num) {
      return NSPrice(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSPrice operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value * other.value);
    }
    else if(other is num) {
      return NSPrice(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSPrice operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value / other.value);
    }
    else if(other is num) {
      return NSPrice(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSPrice operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSPrice(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSPrice operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value % other.value);
    }
    else if(other is num) {
      return NSPrice(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSPrice remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSPrice(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSPrice(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSPrice inc() {
    this.value++;
    return this;
  }

  @override
  NSPrice dec() {
    this.value--;
    return this;
  }

  @override
  NSPrice abs() {
    return this.value == null ? null : NSPrice(n: this.value.abs());
  }
}
