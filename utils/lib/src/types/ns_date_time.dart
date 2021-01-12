import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:utils/utils.dart';

class NSDateTime implements Comparable<NSDateTime> {
  static Locale defaultLocale;
  static DateFormat defaultFormat;
  static DateFormat ddMMyyyyhhmmssmmmm;
  static DateFormat defaultDateFormat;
  static DateFormat timelineFormat;

  DateFormat format;
  DateTime value;

  NSDateTime({this.value, DateFormat format}) : assert(value != null) {
    this.format = format;
    if(format == null) {
      this.format = defaultFormat;
    }
  }

  NSDateTime toDateTime({DateFormat format}) {
    if(format == null) {
      return this;
    }
    else {
      return NSDateTime(value: this.value, format: this.format);
    }
  }

  NSDate toDate({DateFormat format}) {
    return NSDate(value: this.value, format: format);
  }

  bool operator ==(Object other) {
    if(other == null || this.value == null) {
      return false;
    }
    else if(other is DateTime) {
      return this.value == other;
    }
    else if(other is NSDateTime) {
      return this.value == null || other.value == null ? false : this.value == other.value;
    }
    else if(other is NSDate) {
      return this.value == null || other.value == null ? false : this.value == other.value;
    }
    else {
      return false;
    }
  }

  bool operator >(Object other) {
    if(other == null) {
      return false;
    } else if(other is NSDateTime) {
      return this.value.compareTo(other.value) > 0;
    } else if(other is NSDate) {
      return this.value.compareTo(other.value) > 0;
    } else if(other is DateTime) {
      return this.value.compareTo(other) > 0;
    } else {
      return false;
    }
  }

  bool operator >=(Object other) {
    if(other == null) {
      return false;
    } else if(other is NSDateTime) {
      return this.value.compareTo(other.value) >= 0;
    } else if(other is NSDate) {
      return this.value.compareTo(other.value) >= 0;
    } else if(other is DateTime) {
      return this.value.compareTo(other) >= 0;
    } else {
      return false;
    }
  }

  bool operator <(Object other) {
    if(other == null) {
      return false;
    } else if(other is NSDateTime) {
      return this.value.compareTo(other.value) < 0;
    } else if(other is NSDate) {
      return this.value.compareTo(other.value) < 0;
    } else if(other is DateTime) {
      return this.value.compareTo(other) < 0;
    } else {
      return false;
    }
  }

  bool operator <=(Object other) {
    if(other == null) {
      return false;
    } else if(other is NSDateTime) {
      return this.value.compareTo(other.value) <= 0;
    } else if(other is NSDate) {
      return this.value.compareTo(other.value) <= 0;
    } else if(other is DateTime) {
      return this.value.compareTo(other) <= 0;
    } else {
      return false;
    }
  }

  NSDateTime operator +(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSTime) {
      return NSDateTime(value: this.value.add(other.value));
    }
    else if(other is Duration) {
      return NSDateTime(value: this.value.add(other));
    }
    else {
      return null;
    }
  }

  NSDateTime operator -(Object other) {
    if(other == null) {
      return null;
    }
    else if(other is NSTime) {
      return NSDateTime(value: this.value.subtract(other.value));
    }
    else if(other is Duration) {
      return NSDateTime(value: this.value.subtract(other));
    }
    else {
      return null;
    }
  }

  NSTime remainder(Object other) {
    if(other == null) {
      return null;
    } else if(other is NSDateTime) {
      return NSTime(value: this.value.difference(other.value));
    } else if(other is DateTime) {
      return NSTime(value: this.value.difference(other));
    } else {
      return null;
    }
  }

  NSDayOfWeek dayOfWeek() {
    return NSDayOfWeek.fromDateTime(this);
  }

  NSDateTime addWeeks(int weeks) {
    weeks = weeks < 0 ? 0 : weeks;
    return this + NSTime(value: Duration(days: NSDayOfWeek.diasPorSemana * weeks));
  }

  NSDateTime subtractWeeks(int weeks) {
    weeks = weeks < 0 ? 0 : weeks;
    return this - NSTime(value: Duration(days: NSDayOfWeek.diasPorSemana * weeks));
  }

  static NSDateTime now() {
    return NSDateTime(value: DateTime.now());
  }

  @override
  int compareTo(NSDateTime other) {
    return value.compareTo(other.value);
  }

  int get hashCode {
    return value == null ? null : value.hashCode;
  }

  @override
  String toString() {
    if(format == null) {
      format = defaultFormat;
    }
    return format.format(this.value);
  }

  int get microsecond {
    return value.microsecond;
  }

  int get millisecond {
    return value.millisecond;
  }

  int get hour {
    return value.hour;
  }

  int get minute {
    return value.minute;
  }

  int get day {
    return value.day;
  }

  int get month {
    return value.month;
  }

  int get year {
    return value.year;
  }

  int get second {
    return value.second;
  }

  static NSDateTime fromString(String dateTime, {DateFormat format, bool utc = false}) {
    if(format == null) {
      try {
        return NSDateTime(value: defaultFormat.parse(dateTime, utc));
      } catch(e) {
        return NSDateTime(value: defaultFormat.parse(dateTime + " 00:00:00", utc));
      }
    }
    else {
      return NSDateTime(value: format.parse(dateTime + " 00:00:00", utc));
    }
  }

  static NSDateTime parse(String formattedString) {
    return NSDateTime(value: DateTime.parse(formattedString));
  }

  static Future initFormats() {
    Locale toUse = TypeUtils.getDefaultLocale();

    if(anyFormatNull()) {
      String localeStr = TypeUtils.fromLocale(toUse);
      return initializeDateFormatting(localeStr, null).then((_) => internalInit(toUse));
    }
    else {
      return Future.value(null);
    }
  }

  static bool anyFormatNull(){
    return defaultLocale == null ||
        defaultFormat == null ||
        ddMMyyyyhhmmssmmmm == null ||
        defaultDateFormat == null ||
        timelineFormat == null;
  }

  static void internalInit(Locale locale) {
    defaultLocale = locale;
    defaultFormat = DateFormat("dd/MM/yyyy HH:mm:ss", TypeUtils.fromLocale(defaultLocale));
    ddMMyyyyhhmmssmmmm = DateFormat("dd/MM/yyyy HH:mm:ss.aaaa", TypeUtils.fromLocale(defaultLocale));
    defaultDateFormat = DateFormat("dd/MM/yyyy", TypeUtils.fromLocale(defaultLocale));
    timelineFormat = DateFormat("dd' de 'MMMM", TypeUtils.fromLocale(defaultLocale));
  }
}