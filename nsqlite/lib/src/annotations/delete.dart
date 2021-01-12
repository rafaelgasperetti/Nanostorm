class Delete {
  final String sql;

  @override
  String toString() {
    return 'Delete{sql: $sql}';
  }

  const Delete(this.sql);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Delete && runtimeType == other.runtimeType && sql == other.sql;

  @override
  int get hashCode => sql.hashCode;
}

const delete = Delete(null);
