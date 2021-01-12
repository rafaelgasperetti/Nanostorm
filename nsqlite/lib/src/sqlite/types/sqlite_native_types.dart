import 'dart:typed_data';

import 'package:nsqlite/src/sqlite/impl/sqlite_blob_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_double_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_int32_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_int64_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_int_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_string_column.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteInt extends NativeType<int> {
  SQLiteInt() : super('INT');

  @override
  Column<int> getColumn(Statement statement, int index) {
    return SQLiteIntColumn(statement, index);
  }
}

class SQLiteInt32 extends NativeType<int> {
  SQLiteInt32() : super('INT', defaultForType: false);

  @override
  Column<int> getColumn(Statement statement, int index) {
    return SQLiteInt32Column(statement, index);
  }
}

class SQLiteInt64 extends NativeType<int> {
  SQLiteInt64() : super('INT', defaultForType: false);

  @override
  Column<int> getColumn(Statement statement, int index) {
    return SQLiteInt64Column(statement, index);
  }
}

class SQLiteDouble extends NativeType<num> {
  SQLiteDouble() : super('REAL');

  @override
  Column<num> getColumn(Statement statement, int index) {
    return SQLiteDoubleColumn(statement, index);
  }
}

class SQLiteText extends NativeType<String> {
  SQLiteText() : super('TEXT');

  @override
  Column<String> getColumn(Statement statement, int index) {
    return SQLiteStringColumn(statement, index);
  }
}

class SQLiteBlob extends NativeType<Uint8List> {
  SQLiteBlob() : super('BLOB');

  @override
  Column<Uint8List> getColumn(Statement statement, int index) {
    return SQLiteBlobColumn(statement, index);
  }
}
