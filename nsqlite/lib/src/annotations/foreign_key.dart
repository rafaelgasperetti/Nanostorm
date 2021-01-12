import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';
import 'package:meta/meta.dart';

import 'constraints.dart';

class ForeignKey extends Constraint
    implements TableConstraint, FieldConstraint {
  final List<String> fields;
  final String references;
  final List<String> fkFields;
  final ForeignKeyAction onDelete;
  final ForeignKeyAction onUpdate;

  const ForeignKey(
      {@required this.references,
      this.fields,
      String name,
      this.fkFields,
      this.onDelete = ForeignKeyAction.none,
      this.onUpdate = ForeignKeyAction.none})
      : super(name);

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getForeignKey(this);
  }

  @override
  String toString() {
    return 'ForeignKey{fields: $fields, references: $references, fkFields: $fkFields, onDelete: $onDelete, onUpdate: $onUpdate}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForeignKey &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          references == other.references &&
          onDelete == other.onDelete &&
          onUpdate == other.onUpdate &&
          fields.equals(other.fields) &&
          fkFields.equals(other.fkFields);

  @override
  int get hashCode =>
      name.hashCode ^
      references.hashCode ^
      onDelete.hashCode ^
      onUpdate.hashCode ^
      fields.hashCode ^
      fkFields.hashCode;
}

enum ForeignKeyAction {
  none,
  cascade,
  restrict,
  setDefault,
  setNull,
}
