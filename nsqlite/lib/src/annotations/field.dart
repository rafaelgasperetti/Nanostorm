import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/base/types.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'autoincrement.dart' as autoIncrementDef;
import 'collate.dart';
import 'default.dart';
import 'nullable.dart' as nullDef;
import 'primary_key.dart' as primaryKeyDef;
import 'unique.dart' as uniqueDef;

class Field implements SQLItem {
  final String name;
  final String collation;
  final int size;
  final int decimals;
  final bool notNull;
  final bool autoIncrement;
  final bool primaryKey;
  final bool unique;
  final String defaultValue;
  final List<FieldConstraint> constraints;
  static const MAX_SIZE = -1;
  final DataType dataType;

  bool get nullable => !notNull;

  /*
  SqlType type;
  String description;
  String keyboardType;
  String controlType;
  String mask;
  bool readOnly;
  int idLista;
  int order;*/

  const Field(
      {this.name,
      this.collation,
      this.size,
      this.decimals,
      this.notNull = false,
      this.autoIncrement = false,
      this.primaryKey = false,
      this.unique = false,
      this.defaultValue,
      this.constraints})
      : this.dataType = null;

  Field.withValidate(
      {this.name,
      String collation,
      this.size,
      this.decimals,
      bool notNull = false,
      bool autoIncrement = false,
      bool primaryKey = false,
      bool unique,
      String defaultValue,
      List<FieldConstraint> constraints,
      this.dataType})
      : constraints = constraints ?? [],
        collation = collation ??
            constraints?.whereType<Collate>()?.firstOrNull?.collate,
        defaultValue = defaultValue ??
            constraints?.whereType<Default>()?.firstOrNull?.expression,
        notNull = notNull ??
            constraints?.whereType<nullDef.Nullable>()?.firstOrNull?.notNull ??
            false,
        unique = unique ??
            constraints?.whereType<uniqueDef.FieldUnique>()?.isNotEmpty ??
            false,
        primaryKey = primaryKey ??
            constraints
                ?.whereType<primaryKeyDef.FieldPrimaryKey>()
                ?.isNotEmpty ??
            false,
        autoIncrement = autoIncrement ??
            constraints
                ?.whereType<autoIncrementDef.AutoIncrement>()
                ?.isNotEmpty ??
            false {
    Collate collate = this.constraints.whereType<Collate>().firstOrNull;
    nullDef.Nullable nullable =
        this.constraints.whereType<nullDef.Nullable>().firstOrNull;
    autoIncrementDef.AutoIncrement autoIncrementConstraint = this
        .constraints
        .whereType<autoIncrementDef.AutoIncrement>()
        .firstOrNull;
    primaryKeyDef.FieldPrimaryKey primaryKeyConstraint =
        this.constraints.whereType<primaryKeyDef.FieldPrimaryKey>().firstOrNull;
    uniqueDef.FieldUnique uniqueConstraint =
        this.constraints.whereType<uniqueDef.FieldUnique>().firstOrNull;
    Default defaultConstraint =
        this.constraints.whereType<Default>().firstOrNull;

    if (this.collation != null && collate == null) {
      this.constraints.add(Collate(this.collation));
    } else if (this.collation != null && collate != null) {
      assert(this.collation == collate.collate,
          'collation field and constraint must be equals');
    }

    if (this.notNull && nullable == null) {
      this.constraints.add(this.notNull ? nullDef.notNull : nullDef.nullable);
    } else if (this.notNull && nullable != null) {
      assert(notNull == nullable.notNull,
          'notNull field and constraint must be equals');
    }

    if (this.autoIncrement && autoIncrementConstraint == null) {
      this.constraints.add(autoIncrementDef.autoIncrement);
    }

    if (this.primaryKey && primaryKeyConstraint == null) {
      this.constraints.add(primaryKeyDef.primaryKey);
    }

    if (this.unique && uniqueConstraint == null) {
      this.constraints.add(uniqueDef.unique);
    }

    if (this.defaultValue != null && defaultConstraint == null) {
      this.constraints.add(Default(this.defaultValue));
    } else if (this.defaultValue != null && defaultConstraint != null) {
      assert(this.defaultValue == defaultConstraint.expression,
          'defaultValue field and constraint must be equals');
    }
  }

  @override
  String toString() {
    return 'Field{name: $name, collation: $collation, size: $size, decimals: $decimals, notNull: $notNull, autoIncrement: $autoIncrement, primaryKey: $primaryKey, unique: $unique, defaultValue: $defaultValue, constraints: $constraints, dataType: $dataType}';
  }

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getField(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Field &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          collation == other.collation &&
          dataType == other.dataType &&
          size == other.size &&
          decimals == other.decimals &&
          notNull == other.notNull &&
          autoIncrement == other.autoIncrement &&
          primaryKey == other.primaryKey &&
          unique == other.unique &&
          defaultValue == other.defaultValue &&
          constraints.equals(other.constraints);

  @override
  int get hashCode =>
      name.hashCode ^
      collation.hashCode ^
      dataType.hashCode ^
      size.hashCode ^
      decimals.hashCode ^
      notNull.hashCode ^
      autoIncrement.hashCode ^
      primaryKey.hashCode ^
      unique.hashCode ^
      defaultValue.hashCode ^
      constraints.hashCode;
}
