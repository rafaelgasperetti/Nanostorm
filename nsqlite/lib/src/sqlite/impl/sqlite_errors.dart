import 'dart:ffi';

import '../../ffi/blob.dart';
import '../../ffi/types.dart';
import '../native/bindings.dart';

class SQLiteException implements Exception {
  final String message;
  final String explanation;

  SQLiteException(this.message, [this.explanation]);

  factory SQLiteException.fromErrorCode(Pointer<Database> db, int code) {
    // We don't need to free the pointer returned by sqlite3_errmsg: 'Memory to
    // hold the error message string is managed internally. The application does
    // not need to worry about freeing the result.'
    // https://www.sqlite.org/c3ref/errcode.html
    final dbMessage = bindings.sqlite3_errmsg(db).readString();

    String explanation;
    if (code != null) {
      explanation = bindings.sqlite3_errstr(code).readString();
    }

    return SQLiteException(dbMessage, explanation);
  }

  @override
  String toString() {
    if (explanation == null) {
      return 'SqliteException: $message';
    } else {
      return 'SqliteException: $message, $explanation';
    }
  }
}
