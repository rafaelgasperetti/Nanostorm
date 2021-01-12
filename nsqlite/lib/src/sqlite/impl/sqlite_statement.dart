import 'dart:ffi';

import 'package:nsqlite/src/sqlite/impl/sqlite_dynamic_column.dart';
import 'package:nsqlite/nsqlite.dart';
import 'package:ffi/ffi.dart';

import '../../ffi/blob.dart';
import '../../ffi/types.dart' as types;
import '../../ffi/utils.dart';
import '../native/bindings.dart';
import '../native/constants.dart';
import 'sqlite_column.dart';
import 'sqlite_errors.dart';
import 'sqlite_parameters.dart';

class SQLiteStatement implements Statement<Pointer<types.Statement>>, Cursor {
  @override
  Database database;

  @override
  Parameters<Pointer<types.Statement>> parameters;

  @override
  Pointer<types.Statement> compiledStatement;

  bool _closed = false;

  SQLiteStatement(this.database, String sql,
      [List<dynamic> params, Map<String, dynamic> namedParams]) {
    final stmtOut = allocate<Pointer<types.Statement>>();
    final sqlPtr = CBlob.allocateString(sql);
    final resultCode = bindings.sqlite3_prepare_v2(
        database.dbHandle, sqlPtr, -1, stmtOut, nullptr.cast());
    sqlPtr.free();
    compiledStatement = stmtOut.value;
    stmtOut.free();

    if (resultCode != Errors.SQLITE_OK) {
      // we don't need to worry about freeing the statement. If preparing the
      // statement was unsuccessful, stmtOut.load() will be null
      throw SQLiteException.fromErrorCode(database.dbHandle, resultCode);
    } else {
      database.statementAllocated(this);
    }

    parameters = new SQLiteParameters(compiledStatement);
    if (params != null) {
      parameters.bind(params);
    } else if (namedParams != null) {
      parameters.bindNamed(namedParams);
    }
  }

  @override
  void close() {
    if (!_closed) {
      parameters.release();
      bindings.sqlite3_finalize(compiledStatement);
      database.statementReleased(this);
    }
    _closed = true;
  }

  @override
  void execute([List<dynamic> params]) {
    _ensureNotFinalized();
    if (params != null) {
      parameters.bind(params);
    }
    final result = _step();
    if (result != Errors.SQLITE_OK && result != Errors.SQLITE_DONE) {
      throw SQLiteException.fromErrorCode(database.dbHandle, result);
    }
  }

  @override
  void query([List<dynamic> params]) {
    _ensureNotFinalized();
    if (params != null) {
      parameters.bind(params);
    }

    int columnCount = bindings.sqlite3_column_count(compiledStatement);
    _columns = List<SQLiteColumn>(columnCount);
    for (int i = 0; i < columnCount; i++) {
      _columns[i] = SQLiteDynamicColumn(this, i);
    }
  }

  @override
  QueryResult select([List<dynamic> params]) {
    query(params);
    return QueryResult(_getColumnNames(), _getRows());
  }

  List<String> _getColumnNames() {
    int nColumns = columns.length;
    final names = List<String>(nColumns);
    int i = 0;
    for (var column in columns) {
      names[i++] = column.name;
    }
    return names;
  }

  List<dynamic> _getRows() {
    final rows = <List<dynamic>>[];
    int nColumns = columns.length;

    while (next()) {
      rows.add([for (int i = 0; i < nColumns; i++) columns[i].value]);
    }
    return rows;
  }

  @override
  bool next() {
    return (_step() == Errors.SQLITE_ROW);
  }

  int _step() {
    _ensureNotFinalized();
    return bindings.sqlite3_step(compiledStatement);
  }

  void _ensureNotFinalized() {
    if (_closed) {
      throw StateError('Tried to operate on a released prepared statement');
    }
  }

  List<Column> _columns;

  @override
  List<Column> get columns => _columns ?? List<SQLiteColumn>(0);
}
