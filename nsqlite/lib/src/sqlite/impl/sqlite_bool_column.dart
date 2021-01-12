import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteBoolColumn extends SQLiteColumn<bool> {
  SQLiteBoolColumn(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  bool get value => int32Value != 0;

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindInt32(index, int32Value);
  }
}
