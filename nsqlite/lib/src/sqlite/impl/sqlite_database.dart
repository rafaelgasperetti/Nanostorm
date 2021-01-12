import 'dart:ffi';
import 'dart:io';

import 'package:nsqlite/nsqlite.dart';
import 'package:ffi/ffi.dart';

import '../../ffi/blob.dart';
import '../../ffi/types.dart' as types;
import '../../ffi/utils.dart';
import '../native/bindings.dart';
import '../native/constants.dart';
import 'sqlite_dialect.dart';
import 'sqlite_errors.dart';
import 'sqlite_query_executor.dart';
import 'sqlite_statement.dart';

const _openingFlags = Flags.SQLITE_OPEN_READWRITE | Flags.SQLITE_OPEN_CREATE;

class SQLiteDatabase extends SQLiteQueryExecutor implements Database {
  Pointer<types.Database> _dbHandle;

  @override
  Pointer<types.Database> get dbHandle => _dbHandle;

  SQLiteDatabase(this._dbHandle);

  factory SQLiteDatabase.memory() => SQLiteDatabase.open(':memory:');

  factory SQLiteDatabase.openFile(File file) =>
      SQLiteDatabase.open(file.absolute.path);

  factory SQLiteDatabase.open(String fileName) {
    final dbOut = allocate<Pointer<types.Database>>();
    final pathC = CBlob.allocateString(fileName);

    final resultCode =
        bindings.sqlite3_open_v2(pathC, dbOut, _openingFlags, nullptr.cast());
    final dbPointer = dbOut.value;

    dbOut.free();
    pathC.free();

    if (resultCode == Errors.SQLITE_OK) {
      return new SQLiteDatabase(dbPointer);
    } else {
      bindings.sqlite3_close_v2(dbPointer);
      throw SQLiteException.fromErrorCode(dbPointer, resultCode);
    }
  }

  @override
  void closeDatabase() {
    int resultCode = bindings.sqlite3_close_v2(dbHandle);
    if (resultCode != Errors.SQLITE_OK) {
      throw SQLiteException.fromErrorCode(dbHandle, resultCode);
    }
  }

  @override
  void setSchemaVersion(int version) {
    execute('PRAGMA user_version = $version');
  }

  @override
  int schemaVersion() {
    final cursor = query('PRAGMA user_version');
    int result = -1;
    if (cursor.next()) {
      result = cursor.columns[0].value;
    }
    cursor.close();

    return result;
  }

  bool _closed = false;

  @override
  bool isOpen() => !_closed;

  @override
  bool isClosed() => _closed;

  void close() {
    if (isOpen()) {
      _closed = true;
      releaseStatements();
      closeDatabase();
    }
  }

  @override
  void ensureOpen() {
    if (isClosed()) {
      throw Exception('This database has already been closed');
    }
  }

  // Statements management
  final List<Statement> _allocatedStatements = [];

  @override
  void statementAllocated(Statement statement) {
    _allocatedStatements.add(statement);
  }

  @override
  void statementReleased(Statement statement) {
    if (isOpen()) {
      _allocatedStatements.remove(statement);
    }
  }

  @override
  void releaseStatements() {
    for (Statement statement in _allocatedStatements) {
      statement.close();
    }
    _allocatedStatements.clear();
  }

  @override
  Statement prepare(String sql, [List<dynamic> params]) {
    ensureOpen();
    return SQLiteStatement(this, sql, params);
  }

  @override
  SqlDialect get dialect => SQLiteDialect.getInstance();
}
