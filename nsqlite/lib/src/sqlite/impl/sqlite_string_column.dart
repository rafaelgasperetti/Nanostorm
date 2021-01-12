import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteStringColumn extends SQLiteColumn<String> {
  SQLiteStringColumn(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  String get value => stringValue;

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindString(index, stringValue);
  }
}
