class Insert {
  final String sql;
  final ConflictResolution conflictResolution;

  const Insert(this.sql, [this.conflictResolution]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Insert && runtimeType == other.runtimeType && sql == other.sql;

  @override
  String toString() {
    return 'Insert{sql: $sql, conflictResolution: $conflictResolution}';
  }

  @override
  int get hashCode => sql.hashCode;
}

const insert = Insert(null);

enum ConflictResolution { rollback, ignore, fail, abort, replace }
