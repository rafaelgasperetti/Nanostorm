import 'package:nsqlite/src/base/sql_dialect.dart';

import 'query_executor.dart';
import 'statement.dart';

abstract class Database extends QueryExecutor {
  /// Check if database is open.
  bool isOpen();

  /// Check if database is closed.
  bool isClosed();

  /// Close database only.
  void closeDatabase();

  /// This method should invoke releaseStatements() before close the database itself.
  /// Closes this database connection and releases the resources it uses. If
  /// an error occurs while closing the database, an exception will be thrown.
  /// The allocated memory will be freed either way.
  void close();

  /// Get the application defined version of this database.
  int schemaVersion();

  /// Update the application defined version of this database.
  void setSchemaVersion(int version);

  /// Keep reference to all allocated statements
  void statementAllocated(Statement statement);

  /// Remove reference to this allocated statement. It has been released.
  void statementReleased(Statement statement);

  /// Release all allocated statements
  void releaseStatements();

  SqlDialect get dialect;
}
