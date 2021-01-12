import 'dart:core';

import '../interfaces/async_database.dart';
import 'read_dao.dart';
import 'record.dart';

abstract class ReadWriteDao<T extends ReadWriteRecord> extends ReadOnlyDao<T> {
  ReadWriteDao(AsyncDatabase db) : super(db);

  static String _sqlInsert;
  static String _sqlInsertOrReplace;
  static String _sqlUpdate;
  static String _sqlUpdateOrIgnore;
  static String _sqlDelete;

  String get sqlInsert =>
      _sqlInsert ??= db.dialect.getInsertSQL(db.getTable(T));

  String get sqlInsertOrReplace =>
      _sqlInsertOrReplace ??= db.dialect.getInsertSQL(db.getTable(T), true);

  String get sqlUpdate =>
      _sqlUpdate ??= db.dialect.getUpdateSQL(db.getTable(T));

  String get sqlUpdateOrIgnore =>
      _sqlUpdateOrIgnore ??= db.dialect.getUpdateSQL(db.getTable(T), true);

  String get sqlDelete =>
      _sqlDelete ??= db.dialect.getDeleteSQL(db.getTable(T));

  Future<void> update(T record) async {
    db.execute(sqlUpdate, record.updateFieldsParams());
  }

  Future<void> updateAll(List<T> recordList) async {
    for (T record in recordList) {
      update(record);
    }
  }

  Future<void> updateOrIgnore(T record) async {
    db.execute(sqlUpdateOrIgnore, record.updateFieldsParams());
  }

  Future<void> updateOrIgnoreAll(List<T> recordList) async {
    for (T record in recordList) {
      updateOrIgnore(record);
    }
  }

  Future<int> updateWithResult(T record) async {
    await update(record);
    return db.getAffectedRows();
  }

  Future<int> updateAllWithResult(List<T> recordList) async {
    int rowsCount = 0;
    for (T record in recordList) {
      rowsCount += await deleteWithResult(record);
    }
    return rowsCount;
  }

  Future<void> delete(T record) async {
    db.execute(sqlDelete, record.primaryKeyFieldsParams());
  }

  Future<void> deleteAll(List<T> recordList) async {
    for (T record in recordList) {
      delete(record);
    }
  }

  Future<int> deleteWithResult(T record) async {
    await delete(record);
    return db.getAffectedRows();
  }

  Future<int> deleteAllWithResult(List<T> recordList) async {
    int rowsCount = 0;
    for (T record in recordList) {
      rowsCount += await deleteWithResult(record);
    }
    return rowsCount;
  }

  Future<void> insert(T record) async {
    db.execute(sqlInsert, record.insertFieldsParams());
  }

  Future<void> insertAll(List<T> recordList) async {
    for (T record in recordList) {
      insert(record);
    }
  }

  Future<void> insertOrReplace(T record) async {
    db.execute(sqlInsertOrReplace, record.insertFieldsParams());
  }

  Future<void> insertOrReplaceAll(List<T> recordList) async {
    for (T record in recordList) {
      insertOrReplace(record);
    }
  }

  Future<int> insertWithResult(T record) async {
    await insert(record);
    return db.getAffectedRows();
  }

  Future<int> insertAllWithResult(List<T> recordList) async {
    int rowsCount = 0;
    for (T record in recordList) {
      rowsCount += await insertWithResult(record);
    }
    return rowsCount;
  }
}
