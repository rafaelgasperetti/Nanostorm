import 'package:flutter/widgets.dart';

import 'package:utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NSTime implements Comparable<NSTime> {
  static Locale defaultLocale;
  static DateFormat defaultFormat;
  static DateFormat extendedFormat;

  Duration value;
  DateFormat format;

  NSTime({
    Duration value,
    NSDateTime dateTime,
    NSInt days,
    NSInt hours,
    NSInt minutes,
    NSInt seconds,
    NSInt milliseconds,
    NSInt microseconds
  }) :
    assert(
      (value == null && dateTime != null) ||
      (value != null && dateTime == null) ||
      (days != null || hours != null || minutes != null || seconds != null || milliseconds != null || microseconds != null)
    ) {
    initFormats();

    if(value != null) {
      this.value = value;
    }
    else if(dateTime != null) {
      this.value = fromDateTime(NSDateTime(value: dateTime.value)).value;
    }
    else {
      this.value = Duration(
          days: days != null ? days.value : 0,
          hours: hours != null ? hours.value : 0,
          minutes: minutes != null ? minutes.value : 0,
          seconds: seconds != null ? seconds.value : 0,
          milliseconds: milliseconds != null ? milliseconds.value : 0,
          microseconds: microseconds != null ? microseconds.value : 0
      );
    }
  }

  bool operator ==(Object other) {
    if(other == null || this.value == null) {
      return false;
    }
    else if(other is Duration) {
      return this.value == other;
    }
    else if(other is NSTime) {
      return this.value == null || other.value == null ? false : this.value == other.value;
    }
    else {
      return false;
    }
  }

  bool operator >(NSTime other) {
    if(other == null) {
      return false;
    } else {
      return this.value.compareTo(other.value) > 0;
    }
  }

  bool operator >=(NSTime other) {
    if(other == null) {
      return false;
    } else {
      return this.value.compareTo(other.value) >= 0;
    }
  }

  bool operator <(NSTime other) {
    if(other == null) {
      return false;
    } else {
      return this.value.compareTo(other.value) < 0;
    }
  }

  bool operator <=(NSTime other) {
    if(other == null) {
      return false;
    } else {
      return this.value.compareTo(other.value) <= 0;
    }
  }

  NSDateTime operator +(NSDateTime other) {
    if(other == null) {
      return null;
    } else {
      return NSDateTime(value: other.value.add(this.value));
    }
  }

  NSDateTime operator -(NSDateTime other) {
    if(other == null) {
      return null;
    } else {
      return NSDateTime(value: other.value.subtract(this.value));
    }
  }

  int get inMicroseconds {
    return value.inMicroseconds;
  }

  int get inMilliseconds {
    return value.inMilliseconds;
  }

  int get inHours {
    return value.inHours;
  }

  int get inMinutes {
    return value.inMinutes;
  }

  int get inDays {
    return value.inDays;
  }

  int get hashCode {
    return value == null ? null : value.hashCode;
  }

  @override
  int compareTo(NSTime other) {
    return other == null ? 1 : value.compareTo(other.value);
  }

  static NSTime fromDateTime(NSDateTime dateTime, {bool withDays = false}) {
    if(dateTime == null) {
      return empty();
    }

    return NSTime(value:
      Duration(
        days: withDays ? dateTime.day : 0,
        hours: dateTime.hour,
        minutes: dateTime.minute,
        seconds: dateTime.second,
        milliseconds: dateTime.millisecond,
        microseconds: dateTime.microsecond
      )
    );
  }

  static NSTime empty() {
    return NSTime(value: Duration());
  }

  static NSTime now() {
    return fromDateTime(NSDateTime.now());
  }

  static NSTime fromString(String dateTime, {DateFormat format, bool utc = false}) {
    initFormats();

    NSDateTime cast;
    if(format == null) {
      cast = NSDateTime.fromString(dateTime, format: defaultFormat, utc: utc);
    }
    else {
      cast = NSDateTime.fromString(dateTime, format: format, utc: utc);
    }

    return NSTime(dateTime: cast);
  }

  static NSDateTime parse(String formattedString) {
    return NSDateTime(value: DateTime.parse(formattedString));
  }

  @override
  String toString() {
    if(format == null) {
      format = defaultFormat;
    }

    NSDateTime dateTime = NSDate.now() + this;
    return format.format(dateTime.value);
  }

  static void initFormats() {
    if(defaultLocale == null) {
      Locale.cachedLocale = Locale.cachedLocale == null ? Locale.fromSubtags(languageCode: "pt", countryCode: "BR") : Locale.cachedLocale;
      defaultLocale = Locale.cachedLocale;
      defaultFormat = DateFormat('HH:mm:ss', defaultLocale.toString());
      extendedFormat = DateFormat('HH:mm:ss.aaa', defaultLocale.toString());
    }
  }
}