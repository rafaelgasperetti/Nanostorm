import 'package:nsqlite/src/sqlite/impl/sqlite_column.dart';
import 'package:nsqlite/src/sqlite/impl/sqlite_statement.dart';
import 'package:nsqlite/nsqlite.dart';

class SQLiteIntColumn extends SQLiteColumn<int> {
  SQLiteIntColumn(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  int get value => int64Value;

  @override
  void bindTo(Parameters parameters, int index) {
    var v = value;
    if (v.bitLength > 32) {
      parameters.bindInt64(index, v);
    } else {
      parameters.bindInt32(index, v);
    }
  }
}
