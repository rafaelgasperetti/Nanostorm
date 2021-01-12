import 'insert.dart';

class Update {
  final String sql;
  final ConflictResolution conflictResolution;

  const Update(this.sql, [this.conflictResolution]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Update &&
          runtimeType == other.runtimeType &&
          sql == other.sql &&
          conflictResolution == other.conflictResolution;

  @override
  String toString() {
    return 'Update{sql: $sql, conflictResolution: $conflictResolution}';
  }

  @override
  int get hashCode => sql.hashCode ^ conflictResolution.hashCode;
}

const update = Update(null);
