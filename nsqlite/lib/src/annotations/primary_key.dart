import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'constraints.dart';
import 'index.dart';

class PrimaryKey extends Constraint implements TableConstraint {
  final List<IndexField> fields;

  const PrimaryKey(this.fields, {String name})
      : assert(fields != null),
        super(name);

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getPrimaryKey(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimaryKey &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          fields.equals(other.fields);

  @override
  String toString() {
    return 'PrimaryKey{fields: $fields, name: $name}';
  }

  @override
  int get hashCode => name.hashCode ^ fields.hashCode;
}

class FieldPrimaryKey extends Constraint implements FieldConstraint {
  const FieldPrimaryKey() : super();

  @override
  String toString() {
    return 'FieldPrimaryKey{}';
  }

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getPrimaryKey(null);
  }
}

const primaryKey = FieldPrimaryKey();
