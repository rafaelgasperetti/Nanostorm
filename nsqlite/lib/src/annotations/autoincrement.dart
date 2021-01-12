import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

class AutoIncrement implements FieldConstraint {
  const AutoIncrement._();

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getAutoIncrement(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoIncrement && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'AutoIncrement{}';
  }
}

const autoIncrement = AutoIncrement._();
