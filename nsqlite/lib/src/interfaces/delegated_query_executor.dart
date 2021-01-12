import '../base/query_result.dart';
import 'cursor.dart';
import 'statement.dart';
import 'transaction.dart';

abstract class DelegatedQueryExecutor {
  /// Runs a select statement with the given variables and returns the raw results.
  Future<QueryResult> select(String sql, [List<dynamic> params]);

  /// Runs a select statement with the given variables and returns an open cursor.
  Future<Cursor> query(String sql, [List<dynamic> params]);

  /// Runs a query statement with the given variables that returns nothing.
  Future<void> execute(String sql, [List<dynamic> params]);

  /// Runs a query statement with the given variables that returns number of  affected rows.
  Future<int> executeWithResult(String sql, [List<dynamic> params]);

  /// Ensures that database is open or throw an exception
  Future<void> ensureOpen();

  /// Starts a [Transaction].
  Future<Transaction> beginTransaction();

  /// Returns the amount of rows affected by the last INSERT, UPDATE or DELETE statement.
  Future<int> getAffectedRows();

  /// Returns the row-id of the last inserted row.
  Future<int> getLastInsertId();

  /// Returns a Compiled Statement ready to be executed or queried;
  Future<Statement> prepare(String sql, [List<dynamic> params]);
}
