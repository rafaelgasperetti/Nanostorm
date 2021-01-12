import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

class Nullable implements FieldConstraint {
  final bool allowNull;

  const Nullable._(this.allowNull);

  bool get notNull => !allowNull;

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getNull(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Nullable &&
          runtimeType == other.runtimeType &&
          allowNull == other.allowNull;

  @override
  String toString() {
    return 'Nullable{allowNull: $allowNull}';
  }

  @override
  int get hashCode => allowNull.hashCode;
}

const notNull = Nullable._(false);
const nullable = Nullable._(true);
