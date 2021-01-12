import 'dart:async';
import 'dart:io';

import 'package:nsqlite/nsqlite.dart';
import 'package:synchronized/synchronized.dart';

/// A bssqlite database that runs on the Dart VM.
class VmDatabase extends AsyncDatabase<SQLiteDatabase> {
  @override
  SQLiteDatabase db;

  String dbFile;
  bool logStatements = false;
  final Lock _openingLock = Lock();

  VmDatabase(this.dbFile, [this.logStatements]);

  factory VmDatabase.file(File file, {bool logStatements = false}) {
    return VmDatabase(file.absolute.path, logStatements);
  }

  /// Creates an in-memory database won't persist its changes on disk.
  factory VmDatabase.memory({bool logStatements = false}) {
    return VmDatabase(null, logStatements);
  }

  void _log(String sql, List<dynamic> params) {
    if (logStatements) {
      print('bssqlite: SQL: $sql with params $params');
    }
  }

  @override
  Future<Statement> prepare(String sql, [List params]) async {
    _log(sql, params);
    return super.prepare(sql, params);
  }

  Future<bool> exists() async {
    return File(dbFile).exists();
  }

  @override
  bool isClosed() {
    return db == null || db.isClosed();
  }

  @override
  bool isOpen() {
    return db != null && db.isOpen();
  }

  static Future<Directory> getDatabasePath() async {
    return Directory.current;
  }

  static FutureOr<File> getDatabaseFile(String name) async {
    if (name.contains('/') || name.contains('\\')) return File(name);

    return File((await getDatabasePath()).path + '/' + name);
  }

  Future<void> open() async {
    if (dbFile != null) {
      db = SQLiteDatabase.open(dbFile);
    } else {
      db = SQLiteDatabase.memory();
    }
    return Future.value();
  }

  @override
  Future<bool> ensureOpen() {
    return _openingLock.synchronized(() async {
      if (isOpen()) {
        return true;
      }

      await open();
      //await _runMigrations();
      return true;
    });
  }
}
