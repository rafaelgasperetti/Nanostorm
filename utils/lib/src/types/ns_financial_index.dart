import 'dart:math';

import 'package:utils/utils.dart';

class NSFinancialIndex extends NSDecimal {

  NSFinancialIndex({num n, NSDecimal decimal}) : super(n: n, decimal: decimal) {
    setCasasDecimais(getCasasDecimais());
  }

  static NSFinancialIndex getRandom({int max = 1000}) {
    return NSFinancialIndex(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSFinancialIndex(decimal: NSDecimal.ZERO).toString();
  }

  static int getCasasDecimais() {
    return 6;
  }

  @override
  NSFinancialIndex operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value + other.value);
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value - other.value);
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value * other.value);
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value / other.value);
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value % other.value);
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSFinancialIndex(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSFinancialIndex(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSFinancialIndex inc() {
    this.value++;
    return this;
  }

  @override
  NSFinancialIndex dec() {
    this.value--;
    return this;
  }

  @override
  NSFinancialIndex abs() {
    return this.value == null ? null : NSFinancialIndex(n: this.value.abs());
  }
}