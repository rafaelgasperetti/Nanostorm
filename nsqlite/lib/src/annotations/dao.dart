class Dao {
  const Dao._();
}

const dao = Dao._();

class Query {
  final String sql;

  const Query(this.sql);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Query && runtimeType == other.runtimeType && sql == other.sql;

  @override
  int get hashCode => sql.hashCode;

  @override
  String toString() {
    return 'Query{sql: $sql}';
  }
}

class Execute {
  final String sql;

  const Execute(this.sql);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Execute && runtimeType == other.runtimeType && sql == other.sql;

  @override
  int get hashCode => sql.hashCode;

  @override
  String toString() {
    return 'Execute{sql: $sql}';
  }
}

class _Transaction {
  const _Transaction();
}

const transaction = _Transaction();
