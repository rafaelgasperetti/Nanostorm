import 'package:nsqlite/nsqlite.dart';

import '../native/bindings.dart';
import 'sqlite_statement.dart';

abstract class SQLiteQueryExecutor extends QueryExecutor
    implements Transaction {
  @override
  void execute(String sql, [List<dynamic> params]) {
    prepare(sql, params)
      ..execute()
      ..close();
  }

  @override
  QueryResult select(String sql, [List params]) {
    SQLiteStatement statement = prepare(sql, params);
    QueryResult result = statement.select();
    statement.close();
    return result;
  }

  @override
  Cursor query(String sql, [List<dynamic> params]) {
    SQLiteStatement statement = prepare(sql, params);
    statement.query();
    return statement;
  }

  @override
  int getAffectedRows() {
    ensureOpen();
    return bindings.sqlite3_changes(dbHandle);
  }

  @override
  int getLastInsertId() {
    ensureOpen();
    return bindings.sqlite3_last_insert_rowid(dbHandle);
  }

  int _transactionCount = 0;

  @override
  Transaction beginTransaction() {
    execute('BEGIN TRANSACTION;');
    _transactionCount++;
    return this;
  }

  @override
  bool inTransaction() {
    return _transactionCount > 0;
  }

  void ensureActiveTransaction() {
    if (!inTransaction()) throw StateError('No Active Transaction');
  }

  @override
  void commit() {
    ensureActiveTransaction();
    execute('COMMIT TRANSACTION;');
    _transactionCount--;
    return null;
  }

  @override
  void rollback() {
    ensureActiveTransaction();
    execute('ROLLBACK TRANSACTION;');
    _transactionCount--;
    return null;
  }
}
