import 'package:nsqlite/nsqlite.dart';
import 'package:nsqlite/src/annotations/autoincrement.dart';
import 'package:nsqlite/src/annotations/check.dart';
import 'package:nsqlite/src/annotations/collate.dart';
import 'package:nsqlite/src/annotations/constraints.dart';
import 'package:nsqlite/src/annotations/default.dart';
import 'package:nsqlite/src/annotations/field.dart';
import 'package:nsqlite/src/annotations/foreign_key.dart';
import 'package:nsqlite/src/annotations/index.dart';
import 'package:nsqlite/src/annotations/nullable.dart';
import 'package:nsqlite/src/annotations/primary_key.dart';
import 'package:nsqlite/src/annotations/table.dart';
import 'package:nsqlite/src/annotations/trigger.dart';
import 'package:nsqlite/src/annotations/unique.dart';
import 'package:nsqlite/src/annotations/view.dart';
import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

abstract class SqlDialect {
  final String commandSeparator;
  final String fieldConstraintSeparator;
  final String tableConstraintSeparator;
  final String fieldSeparator;
  final String identifierBegin;
  final String identifierEnd;

  DataTypes get dataTypes;

  DataType getDataType(Type theType) =>
      dataTypes.types.where((dataType) => dataType.type == theType).firstOrNull;

  const SqlDialect(
      {this.commandSeparator,
      this.fieldConstraintSeparator,
      this.tableConstraintSeparator,
      this.fieldSeparator,
      this.identifierBegin,
      this.identifierEnd});

  String join(List<SQLItem> list, String separator,
      {String prefix = '', String suffix = ''}) {
    return list == null || list.isEmpty
        ? ''
        : prefix +
            list.map((f) => f.getSQL(this)).toList().join(separator) +
            suffix;
  }

  String getIdentifier(String name, {String prefix = '', String suffix = ''}) {
    return name == null || name.isEmpty
        ? ''
        : '${prefix}${identifierBegin}${name}${identifierEnd}$suffix';
  }

  String getValue(String value, {String prefix = '', String suffix = ''}) {
    return value == null || value.isEmpty
        ? ''
        : '${prefix}${identifierBegin}${value}${identifierEnd}$suffix';
  }

  String getConstraintName(Constraint value);

  String getTableName(Table table);

  String getIndexName(Index index);

  String getTriggerName(Trigger trigger);

  String getViewName(View view);

  String getAutoIncrement(AutoIncrement value);

  String getForeignKey(ForeignKey value);

  String getCollate(Collate value);

  String getIndexField(IndexField field);

  String getPrimaryKey(PrimaryKey value);

  String getCreateIndex(Index index, Table table, [bool whenNotExists = false]);

  String getDropIndex(Index value, Table table, [bool whenExists = false]);

  String getCreateTrigger(Trigger value, Table table,
      [bool whenNotExists = false]);

  String getDropTrigger(Trigger value, Table table, [bool whenExists = false]);

  String getCreateTable(Table table, [bool whenNotExists = false]);

  String getDropTable(Table table, [bool whenExists = false]);

  String getCreateTableAndDependantsSQL(Table table);

  String getCreateView(View value, [bool whenNotExists = false]);

  String getDropView(View value, [bool whenExists = false]);

  String getField(Field field);

  String getInsertSQL(Table table, [bool orReplace = false]);

  String getUpdateSQL(Table table, [bool orIgnore = false]);

  String getDeleteSQL(Table table);

  String getIndexFields(List<IndexField> fields) {
    return join(fields, fieldSeparator, prefix: '(', suffix: ')');
  }

  String getNull(Nullable value) {
    return (value.allowNull ? '' : 'NOT ') + 'NULL';
  }

  String getDefault(Default value) {
    return '${getConstraintName(value)}DEFAULT(${value.expression})';
  }

  String getCheck(Check value) {
    return '${getConstraintName(value)}CHECK(${value.expression})';
  }

  String getUnique(Unique value) {
    return '${getConstraintName(value)}UNIQUE ${getIndexFields(value.fields)}';
  }

  String getForeignKeyAction(ForeignKeyAction action, [String prefix]) {
    switch (action) {
      case ForeignKeyAction.none:
        return '';
      case ForeignKeyAction.cascade:
        return '$prefix CASCADE';
      case ForeignKeyAction.restrict:
        return '$prefix RESTRICT';
      case ForeignKeyAction.setDefault:
        return '$prefix SET DEFAULT';
      case ForeignKeyAction.setNull:
        return '$prefix SET NULL';
    }
  }

  String getTriggerEvent(TriggerEvent event) {
    switch (event) {
      case TriggerEvent.Before:
        return 'BEFORE';
      case TriggerEvent.After:
        return 'AFTER';
      case TriggerEvent.InsteadOf:
        return 'INSTEAD OF';
    }
  }

  String getTriggerAction(TriggerAction action) {
    switch (action) {
      case TriggerAction.Delete:
        return 'DELETE';
      case TriggerAction.Insert:
        return 'INSERT';
      case TriggerAction.Update:
        return 'UPDATE';
    }
  }

  String getType(NativeType nativeType, Field field);
}
