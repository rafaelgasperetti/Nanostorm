import 'dart:math';
import 'package:utils/utils.dart';
import 'package:intl/intl.dart';

class NSQuantityWeight extends NSWeight {

  NSQuantityWeight({num n, NSDecimal decimal}) : super(n: n, decimal: decimal) {
    setCasasDecimais(getCasasDecimais());
  }

  static NSQuantityWeight getRandom({int max = 1000}) {
    return NSQuantityWeight(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSQuantityWeight(decimal: NSDecimal.ZERO).toString();
  }

  static int getCasasDecimais() {
    return 2;
  }

  static NSQuantityWeight fromString(String value, {NumberFormat formatter}) {
    return NSQuantityWeight(decimal: NSWeight.fromString(value, formatter: formatter, casasDecimais: getCasasDecimais()));
  }

  @override
  NSQuantityWeight operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value + other.value);
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value - other.value);
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value * other.value);
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value / other.value);
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value % other.value);
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantityWeight(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSQuantityWeight(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSQuantityWeight inc() {
    this.value++;
    return this;
  }

  @override
  NSQuantityWeight dec() {
    this.value--;
    return this;
  }

  @override
  NSQuantityWeight abs() {
    return this.value == null ? null : NSQuantityWeight(n: this.value.abs());
  }
}