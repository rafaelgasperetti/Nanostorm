import 'package:nsqlite/src/sqlite/types/sqlite_types.dart';
import 'package:nsqlite/nsqlite.dart';
import 'package:queries/collections.dart';

class SQLiteDialect extends SqlDialect {
  static SQLiteDialect _instance;

  SQLiteDialect._()
      : super(
            commandSeparator: ';\r\n ',
            fieldConstraintSeparator: ' ',
            tableConstraintSeparator: ',\r\n',
            fieldSeparator: ', ',
            identifierBegin: '\'',
            identifierEnd: '\'');

  factory SQLiteDialect.getInstance() {
    _instance ??= SQLiteDialect._();
    return _instance;
  }

  String getConstraintName(Constraint value, [String sulfix = '']) {
    return getIdentifier(value?.name, prefix: 'CONSTRAINT', suffix: ' ');
  }

  String getTableName(Table table) {
    return '${getIdentifier(table?.name, prefix: getIdentifier(table.schema, suffix: '.'))}';
  }

  String getViewName(View view) {
    return '${getIdentifier(view?.name, prefix: getIdentifier(view.schema, suffix: '.'))}';
  }

  @override
  String getIndexName(Index index) {
    return index.name;
  }

  @override
  String getTriggerName(Trigger trigger) {
    return trigger.name;
  }

  String getAutoIncrement(AutoIncrement value) {
    return value == null ? '' : 'AUTOINCREMENT';
  }

  String getForeignKey(ForeignKey value) {
    String strFields = value.fields.isEmpty
        ? ''
        : '(' + value.fields.join(fieldSeparator) + ')';
    String strFkFields = value.fkFields.isEmpty
        ? ''
        : '(' + value.fkFields.join(fieldSeparator) + ')';
    String strOnUpdate = getForeignKeyAction(value.onUpdate, ' ON UPDATE');
    String strOnDelete = getForeignKeyAction(value.onDelete, ' ON DELETE');
    return '${getConstraintName(value)}FOREIGN KEY $strFields REFERENCES ${value.references}$strFkFields$strOnDelete$strOnUpdate';
  }

  String getCollate(Collate value) {
    return 'COLLATE ${value.collate}';
  }

  String getIndexFields(List<IndexField> fields) {
    return fields == null || fields.isEmpty
        ? ''
        : '(' + fields.map((f) => getIndexField(f)).join(fieldSeparator) + ')';
  }

  String getIndexField(IndexField field) {
    return '${getIdentifier(field.name)}{${getCollate(field.collation)} ${field.descending ? 'DESC' : 'ASC'}';
  }

  String getPrimaryKey(PrimaryKey value) {
    return '${getConstraintName(value)}PRIMARY KEY ${getIndexFields(value.fields)}';
  }

  String getCreateIndex(Index index, Table table,
      [bool whenNotExists = false]) {
    String strWhere = (index.where == null || index.where.isEmpty)
        ? ''
        : ' WHERE ' + index.where;
    String strInclude = index.includes == null || index.includes.isEmpty
        ? ''
        : ' INCLUDE (' + index.includes.join(fieldSeparator) + ')';

    return 'CREATE ${index.unique ? 'UNIQUE ' : ''}INDEX ${getIndexName(index)} ON ${getTableName(table)}${getIndexFields(index.fields)}$strInclude$strWhere';
  }

  String getDropIndex(Index value, Table table, [bool whenExists = false]) {
    return 'DROP INDEX ${getIndexName(value)} ON ${getTableName(table)}' +
        commandSeparator;
  }

  String getCreateTrigger(Trigger value, Table table,
      [bool whenNotExists = false]) {
    String strWhere = (value.where == null || value.where.isEmpty)
        ? ''
        : ' WHEN ' + value.where;
    return 'CREATE TRIGGER ${getTriggerName(value)} ${getTriggerEvent(value.event)} ${value.actions.map((a) => getTriggerAction(a)).join(', ')} ON ${getTableName(table)} $strWhere\r\nBEGIN\r\n${value.body}\r\nEND' +
        commandSeparator;
  }

  String getDropTrigger(Trigger value, Table table, [bool whenExists = false]) {
    return 'DROP TRIGGER ${getTriggerName(value)} ON ${getTableName(table)}' +
        commandSeparator;
  }

  @override
  String getCreateView(View value, [bool whenNotExists = false]) {
    return 'CREATE VIEW ${getViewName(value)} AS\r\n${value.body}\r\n' +
        commandSeparator;
  }

  @override
  String getDropView(View value, [bool whenExists = false]) {
    return 'DROP VIEW ${getViewName(value)}' + commandSeparator;
  }

  String getCreateTable(Table table, [bool whenNotExists = false]) {
    List<String> result = table.fields.map((f) => f.getSQL(this)).toList();
    result.addAll(table.constraints.map((c) => c.getSQL(this)).toList());

    return 'CREATE TABLE ${getTableName(table)}(${result.join(tableConstraintSeparator)})' +
        commandSeparator;
  }

  String getDropTable(Table table, [bool whenExists = false]) {
    return 'DROP TABLE ${getTableName(table)}' + commandSeparator;
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

  String getField(Field field) {
    String columnDef =
        '${getIdentifier(field.name)} ${field.dataType.getSQL(this, field)}  ${join(field.constraints, fieldConstraintSeparator)}';
    return columnDef;
  }

  String getInsertSQL(Table table, [bool orReplace = false]) {
    String insertList = table.fields.forInsert
        .map((field) => getIdentifier(field.name))
        .toList()
        .join(',');
    String paramList = table.fields.forInsert
        .map((field) => '@' + getIdentifier(field.name))
        .toList()
        .join(',');
    return 'INSERT' +
        (orReplace ? ' OR REPLACE' : '') +
        ' INTO ${getTableName(table)} ($insertList) VALUES ($paramList)';
  }

  String getUpdateSQL(Table table, [bool orIgnore = false]) {
    String updateList = Collection(table.fields.forUpdate)
        .select((field) =>
            getIdentifier(field.name) + ' = @' + getIdentifier(field.name))
        .toList()
        .join(', ');
    String keyFields = Collection(table.fields.primaryKey)
        .select((field) =>
            getIdentifier(field.name) + ' = @' + getIdentifier(field.name))
        .toList()
        .join(' AND ');
    return 'UPDATE' +
        (orIgnore ? ' OR IGNORE' : '') +
        ' ${getTableName(table)} SET ($updateList) WHERE $keyFields';
  }

  String getDeleteSQL(Table table) {
    String keyFields = table.fields.primaryKey
        .map((field) =>
            getIdentifier(field.name) + ' = @' + getIdentifier(field.name))
        .toList()
        .join(' AND ');
    return 'DELETE FROM ${getTableName(table)} WHERE $keyFields';
  }

  @override
  String getCreateTableAndDependantsSQL(Table table) {
    return getCreateTable(table) +
        commandSeparator +
        table.indexes
            .map((i) => getCreateIndex(i, table))
            .toList()
            .join(commandSeparator) +
        commandSeparator +
        table.triggers
            .map((t) => getCreateTrigger(t, table))
            .toList()
            .join(commandSeparator) +
        commandSeparator;
  }

  @override
  String getType(NativeType nativeType, Field field) {
    String strSize =
        nativeType.hasSize && field.size != null ? '${field.size}' : '';
    String strDecimals = nativeType.hasDecimals && field.decimals != null
        ? ', ${field.decimals}'
        : '';
    String extra =
        strDecimals.isEmpty && strSize.isEmpty ? '' : '($strSize$strDecimals)';
    return nativeType.name + extra;
  }

  DataTypes _types = DataTypes(SQLiteTypes().allTypes);

  @override
  DataTypes get dataTypes => _types;
}
