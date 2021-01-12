import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteDoubleColumn extends SQLiteColumn<double> {
  SQLiteDoubleColumn(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  double get value => doubleValue;

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindDouble(index, doubleValue);
  }
}
