import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'constraints.dart';

class Collate extends Constraint implements FieldConstraint, TableConstraint {
  final String collate;

  const Collate(this.collate) : assert(collate != null && collate != '');

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getCollate(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Collate &&
          runtimeType == other.runtimeType &&
          collate == other.collate;

  @override
  int get hashCode => collate.hashCode;

  @override
  String toString() {
    return 'Collate{collate: $collate}';
  }
}
