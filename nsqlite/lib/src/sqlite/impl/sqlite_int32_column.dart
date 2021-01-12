import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteInt32Column extends SQLiteColumn<int> {
  SQLiteInt32Column(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  int get value => int32Value;

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindInt32(index, int32Value);
  }
}
