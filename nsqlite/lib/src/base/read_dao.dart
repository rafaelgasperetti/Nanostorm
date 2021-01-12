import 'dart:core';

import 'package:nsqlite/src/annotations/table.dart';
import 'package:nsqlite/src/interfaces/async_database.dart';
import 'package:nsqlite/src/interfaces/cursor.dart';

import 'record.dart';

abstract class ReadOnlyDao<T extends Record> implements ReadFromCursor {
  final AsyncDatabase db;

  Table get metadata => db.getTable(T);

  ReadOnlyDao(this.db);

  Future<T> querySingle(String sql, List<dynamic> params) async {
    Cursor cursor = await db.query(sql, params);
    T result;
    if (cursor.next()) {
      result = readFromCursor(cursor);
    } else {
      result = null;
    }
    cursor.close();
    return result;
  }

  Future<List<T>> query(String sql, [List<dynamic> params]) async {
    Cursor cursor = await db.query(sql, params);
    List<T> result = List();
    while (cursor.next()) {
      result.add(readFromCursor(cursor));
    }
    cursor.close();
    return result;
  }

  Stream<T> queryStream(String sql, [List<dynamic> params]) async* {
    Cursor cursor = await db.query(sql, params);
    while (cursor.next()) {
      yield readFromCursor(cursor);
    }
    cursor.close();
  }
}
