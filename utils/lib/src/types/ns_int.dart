import 'dart:math';

import 'package:utils/utils.dart';

class NSInt extends NSDecimal {
  NSInt({num n, NSDecimal decimal}) : super(n: n, decimal: decimal) {
    setCasasDecimais(getCasasDecimais());
  }

  static NSInt getRandom({int max = 1000}) {
    return NSInt(n: Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSInt(n: NSDecimal.ZERO).toString();
  }

  static int getCasasDecimais() {
    return 0;
  }

  @override
  NSInt operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value + other.value);
    }
    else if(other is num) {
      return NSInt(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSInt operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value - other.value);
    }
    else if(other is num) {
      return NSInt(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSInt operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value * other.value);
    }
    else if(other is num) {
      return NSInt(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSInt operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value / other.value);
    }
    else if(other is num) {
      return NSInt(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSInt operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSInt(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSInt operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value % other.value);
    }
    else if(other is num) {
      return NSInt(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSInt remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSInt(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSInt(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSInt inc() {
    this.value++;
    return this;
  }

  @override
  NSInt dec() {
    this.value--;
    return this;
  }

  @override
  NSInt abs() {
    return this.value == null ? null : NSInt(n: this.value.abs());
  }
}