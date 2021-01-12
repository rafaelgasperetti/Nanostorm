import 'dart:typed_data';

import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteBlobColumn extends SQLiteColumn<Uint8List> {
  SQLiteBlobColumn(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  Uint8List get value => blobValue;

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindBlob(index, blobValue);
  }
}
