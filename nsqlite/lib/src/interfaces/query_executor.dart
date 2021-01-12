import '../base/query_result.dart';
import 'cursor.dart';
import 'statement.dart';
import 'transaction.dart';

abstract class QueryExecutor<T> {
  T get dbHandle;

  /// Runs a select statement with the given variables and returns the raw results.
  QueryResult select(String sql, [List<dynamic> params]);

  /// Runs a select statement with the given variables and returns an open cursor.
  Cursor query(String sql, [List<dynamic> params]);

  /// Runs a query statement with the given variables that returns nothing.
  void execute(String sql, [List<dynamic> params]);

  /// Ensures that database is open or throw an exception
  void ensureOpen();

  /// Starts a [Transaction].
  Transaction beginTransaction();

  /// Returns the amount of rows affected by the last INSERT, UPDATE or DELETE statement.
  int getAffectedRows();

  /// Returns the row-id of the last inserted row.
  int getLastInsertId();

  /// Returns a Compiled Statement ready to be executed or queried;
  Statement prepare(String sql, [List<dynamic> params]);
}
