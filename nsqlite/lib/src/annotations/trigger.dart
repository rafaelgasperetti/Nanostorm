import 'package:nsqlite/src/annotations/table.dart';
import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

class Trigger implements SQLTableRelatedObject {
  final String name;
  final Set<TriggerAction> actions;
  final TriggerEvent event;
  final String where;
  final String body;

  const Trigger(this.name, this.event, this.actions, this.body, [this.where]);

  @override
  String getCreateSQL(SqlDialect dialect, Table table,
      [bool whenNotExists = false]) {
    return dialect.getCreateTrigger(this, table, whenNotExists);
  }

  @override
  String getDropSQL(SqlDialect dialect, Table table,
      [bool whenExists = false]) {
    return dialect.getDropTrigger(this, table, whenExists);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trigger &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          actions.equals(other.actions) &&
          event == other.event &&
          where == other.where &&
          body == other.body;

  @override
  int get hashCode =>
      name.hashCode ^
      actions.hashCode ^
      event.hashCode ^
      where.hashCode ^
      body.hashCode;

  @override
  String toString() {
    return 'Trigger{name: $name, actions: $actions, event: $event, where: $where, body: $body}';
  }
}

enum TriggerAction { Delete, Insert, Update }

enum TriggerEvent { Before, After, InsteadOf }
