import 'package:nsqlite/nsqlite.dart';

class SQLiteConverters {
  static const SQLiteBoolConverter boolConverter = SQLiteBoolConverter();
  static const SQLiteIntDateTimeConverter intDateTimeConverter =
      SQLiteIntDateTimeConverter();
  static const SQLiteStringDateTimeConverter stringDateTimeConverter =
      SQLiteStringDateTimeConverter();
}

class SQLiteBoolConverter extends TypeConverter<bool, int> {
  const SQLiteBoolConverter();

  @override
  int getDBValue(bool value) {
    return value ? 1 : 0;
  }

  @override
  bool getValue(int value) {
    return value != 0;
  }
}

class SQLiteIntDateTimeConverter extends TypeConverter<DateTime, int> {
  const SQLiteIntDateTimeConverter();

  @override
  int getDBValue(DateTime value) {
    return value.millisecondsSinceEpoch;
  }

  @override
  DateTime getValue(int value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
}

class SQLiteStringDateTimeConverter extends TypeConverter<DateTime, String> {
  const SQLiteStringDateTimeConverter();

  @override
  String getDBValue(DateTime value) {
    return value.toIso8601String();
  }

  @override
  DateTime getValue(String value) {
    return DateTime.parse(value);
  }
}
