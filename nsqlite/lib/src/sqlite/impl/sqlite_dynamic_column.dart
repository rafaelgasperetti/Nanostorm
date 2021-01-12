import 'package:nsqlite/nsqlite.dart';

import '../native/constants.dart';
import 'sqlite_column.dart';
import 'sqlite_statement.dart';

class SQLiteDynamicColumn extends SQLiteColumn<dynamic> {
  SQLiteDynamicColumn(SQLiteStatement statement, int index)
      : super(statement, index);

  @override
  get value => _readValue();

  dynamic _readValue() {
    switch (type) {
      case Types.SQLITE_INTEGER:
        return int64Value;
      case Types.SQLITE_REAL:
        return doubleValue;
      case Types.SQLITE_TEXT:
        return stringValue;
      case Types.SQLITE_BLOB:
        return blobValue;
      case Types.SQLITE_NULL:
      default:
        return null;
    }
  }

  @override
  void bindTo(Parameters parameters, int index) {
    parameters.bindDynamic(index, value);
  }
}
