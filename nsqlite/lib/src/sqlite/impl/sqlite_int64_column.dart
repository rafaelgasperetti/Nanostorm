import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteInt64Column extends SQLiteColumn<int> {
  SQLiteInt64Column(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  int get value => int64Value;

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindInt64(index, int64Value);
  }
}
