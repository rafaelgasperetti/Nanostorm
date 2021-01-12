import 'package:utils/utils.dart';
import 'package:intl/intl.dart';

class NSDate extends NSDateTime {
  NSDate({DateTime value, DateFormat format}) : super(value: value) {
    NSDateTime dateTime = NSDateTime(value: this.value);
    NSDateTime date = dateTime - NSTime.fromDateTime(dateTime);
    this.value = date.value;
    this.format = format;
    if(format == null) {
      this.format = NSDateTime.defaultDateFormat;
    }
  }

  static NSDate now() {
    return NSDate(value: DateTime.now());
  }

  @override
  String toString() {
    if(format == null) {
      format = NSDateTime.defaultDateFormat;
    }
    return format.format(this.value);
  }

  static NSDate fromString(String date, {DateFormat format, bool utc = false}) {
    NSDateTime dateTime = NSDateTime.fromString(date);
    return NSDate(value: dateTime.value);
  }

  static NSDate parse(String formattedString) {
    return NSDate(value: DateTime.parse(formattedString));
  }
}