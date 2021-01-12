import 'dart:math';
import 'package:utils/utils.dart';

class NSQuantity extends NSInt {

  NSQuantity({num n, NSDecimal decimal}) : super(n: n, decimal: decimal);

  static NSQuantity getRandom({int max = 1000}) {
    return NSQuantity(n: Random.secure().nextDouble() + Random.secure().nextInt(max));
  }

  static String toDefaultString() {
    return NSQuantity(decimal: NSDecimal.ZERO).toString();
  }

  @override
  NSQuantity operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value + other.value);
    }
    else if(other is num) {
      return NSQuantity(n: this.value + other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value - other.value);
    }
    else if(other is num) {
      return NSQuantity(n: this.value - other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity operator *(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value * other.value);
    }
    else if(other is num) {
      return NSQuantity(n: this.value * other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity operator /(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value / other.value);
    }
    else if(other is num) {
      return NSQuantity(n: this.value / other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity operator ~/(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value ~/ other.value);
    }
    else if(other is num) {
      return NSQuantity(n: this.value ~/ other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity operator %(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value % other.value);
    }
    else if(other is num) {
      return NSQuantity(n: this.value % other);
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity remainder(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSDecimal) {
      return NSQuantity(n: this.value.remainder(other.value));
    }
    else if(other is num) {
      return NSQuantity(n: this.value.remainder(other));
    }
    else {
      return null;
    }
  }

  @override
  NSQuantity inc() {
    this.value++;
    return this;
  }

  @override
  NSQuantity dec() {
    this.value--;
    return this;
  }

  @override
  NSQuantity abs() {
    return this.value == null ? null : NSQuantity(n: this.value.abs());
  }
}