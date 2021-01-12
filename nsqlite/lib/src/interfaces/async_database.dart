import 'dart:async';

import 'package:nsqlite/nsqlite.dart';
import 'package:synchronized/synchronized.dart';

import '../base/query_result.dart';
import '../base/sql_dialect.dart';
import 'cursor.dart';
import 'database.dart';
import 'delegated_database.dart';
import 'statement.dart';
import 'transaction.dart';

typedef Table TableCreator();

abstract class AsyncDatabase<T extends Database> implements DelegatedDatabase {
  T db;

  final Lock _lock = Lock();
  bool isSequential = true;

  Map<String, TableCreator> _tables = {};

  void registerTable(Type tableType, TableCreator creator) {
    if (!_tables.containsKey(tableType.toString()))
      _tables[tableType.toString()] = creator;
  }

  Table getTableFromName(String tableName) {
    if (_tables.containsKey(tableName)) {
      TableCreator creator = _tables[tableName];
      return creator();
    }
    return null;
  }

  Table getTable(Type tableType) {
    if (_tables.containsKey(tableType.toString())) {
      TableCreator creator = _tables[tableType.toString()];
      return creator();
    }
    return null;
  }

  Future<T> _synchronized<T>(FutureOr<T> Function() action) async {
    if (isSequential) {
      return await _lock.synchronized(action);
    } else {
      // support multiple operations in parallel, so just run right away
      return await action();
    }
  }

  @override
  Future<Transaction> beginTransaction() async {
    return _synchronized(() async {
      await ensureOpen();
      return db.beginTransaction();
    });
  }

  @override
  Future<void> close() async {
    return _synchronized(() {
      db.close();
      return Future.value();
    });
  }

  @override
  Future<void> closeDatabase() async {
    return _synchronized(() {
      db.closeDatabase();
      return Future.value();
    });
  }

  @override
  Future<Statement> prepare(String sql, [List params]) async {
    return _synchronized(() async {
      await ensureOpen();
      return Future.value(db.prepare(sql, params));
    });
  }

  @override
  Future<void> execute(String sql, [List params]) async {
    return _synchronized(() {
      db.execute(sql, params);
      return Future.value();
    });
  }

  @override
  Future<int> executeWithResult(String sql, [List params]) async {
    return _synchronized(() {
      db.execute(sql, params);
      return Future.value(db.getAffectedRows());
    });
  }

  @override
  Future<Cursor> query(String sql, [List params]) async {
    return _synchronized(() {
      return Future.value(db.query(sql, params));
    });
  }

  @override
  Future<QueryResult> select(String sql, [List params]) async {
    return _synchronized(() {
      return Future.value(db.select(sql, params));
    });
  }

  @override
  Future<int> getAffectedRows() async {
    return _synchronized(() async {
      await ensureOpen();
      return Future.value(db.getAffectedRows());
    });
  }

  @override
  Future<int> getLastInsertId() async {
    return _synchronized(() async {
      await ensureOpen();
      return Future.value(db.getLastInsertId());
    });
  }

  @override
  Future<void> releaseStatements() async {
    db.releaseStatements();
    return Future.value();
  }

  @override
  Future<int> schemaVersion() async {
    await ensureOpen();
    return Future.value(db.schemaVersion());
  }

  @override
  Future<void> setSchemaVersion(int version) async {
    await ensureOpen();
    db.setSchemaVersion(version);
    return Future.value();
  }

  @override
  Future<void> statementAllocated(Statement statement) async {
    db.statementAllocated(statement);
    return Future.value();
  }

  @override
  Future<void> statementReleased(Statement statement) async {
    db.statementReleased(statement);
    return Future.value();
  }

  SqlDialect get dialect => db.dialect;
}
