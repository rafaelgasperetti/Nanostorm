import 'dart:typed_data';

import 'package:nsqlite/src/ffi/blob.dart';
import 'package:nsqlite/nsqlite.dart';

import '../native/bindings.dart';
import '../native/constants.dart';
import 'sqlite_statement.dart';

abstract class SQLiteColumn<T> extends Column<T> {
  SQLiteColumn(SQLiteStatement statement, int index) : super(statement, index);

  @override
  String get name => bindings
      .sqlite3_column_name(statement.compiledStatement, index)
      .readString();

  @override
  int get type =>
      bindings.sqlite3_column_type(statement.compiledStatement, index);

  Uint8List get blobValue => _readBlob();

  double get doubleValue =>
      bindings.sqlite3_column_double(statement.compiledStatement, index);

  int get int64Value =>
      bindings.sqlite3_column_int64(statement.compiledStatement, index);

  int get int32Value =>
      bindings.sqlite3_column_int(statement.compiledStatement, index);

  String get stringValue => _readString();

  @override
  bool get isNull => type == Types.SQLITE_NULL;

  String _readString() {
    final length =
        bindings.sqlite3_column_bytes(statement.compiledStatement, index);
    return bindings
        .sqlite3_column_text(statement.compiledStatement, index)
        .readAsStringWithLength(length);
  }

  Uint8List _readBlob() {
    final length =
        bindings.sqlite3_column_bytes(statement.compiledStatement, index);
    return bindings
        .sqlite3_column_blob(statement.compiledStatement, index)
        .readBytes(length);
  }
}
