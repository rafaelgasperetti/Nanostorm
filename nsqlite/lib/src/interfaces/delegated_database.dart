import 'package:nsqlite/src/base/sql_dialect.dart';

import 'delegated_query_executor.dart';
import 'statement.dart';

abstract class DelegatedDatabase extends DelegatedQueryExecutor {
  /// Check if database is open.
  bool isOpen();

  /// Check if database is closed.
  bool isClosed();

  /// Close database only.
  Future<void> closeDatabase();

  /// This method should invoke releaseStatements() before close the database itself.
  /// Closes this database connection and releases the resources it uses. If
  /// an error occurs while closing the database, an exception will be thrown.
  /// The allocated memory will be freed either way.
  Future<void> close();

  /// Get the application defined version of this database.
  Future<int> schemaVersion();

  /// Update the application defined version of this database.
  Future<void> setSchemaVersion(int version);

  /// Keep reference to all allocated statements
  Future<void> statementAllocated(Statement statement);

  /// Remove reference to this allocated statement. It has been released.
  Future<void> statementReleased(Statement statement);

  /// Release all allocated statements
  Future<void> releaseStatements();

  SqlDialect get dialect;
}
