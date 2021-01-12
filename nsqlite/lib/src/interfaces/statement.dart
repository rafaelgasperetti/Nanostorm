import '../base/query_result.dart';
import 'parameters.dart';
import 'query_executor.dart';

abstract class Statement<STATEMENT_TYPE> {
  final QueryExecutor database;
  STATEMENT_TYPE compiledStatement;
  Parameters<STATEMENT_TYPE> parameters;

  Statement(this.database, String sql, [List<dynamic> params]);

  void close();

  void execute([List<dynamic> params]);

  void query([List<dynamic> params]);

  QueryResult select([List<dynamic> params]);

  bool next();
}
