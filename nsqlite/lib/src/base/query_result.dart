import 'dart:collection';

import 'package:collection/collection.dart';

/// Stores the result of a select statement.
class QueryResult extends Iterable<Row> {
  final List<String> columnNames;

  // a result set can have multiple columns with the same name, but that's rare
  // and users usually use a name as index. So we cache that for O(1) lookups

  Map<String, int> _calculatedIndexes;
  final List<List<dynamic>> rows;

  QueryResult(this.columnNames, this.rows) {
    _calculatedIndexes = {
      for (var column in columnNames) column: columnNames.lastIndexOf(column),
    };
  }

  @override
  Iterator<Row> get iterator => _ResultIterator(this);
}

/// Stores a single row in the result of a select statement.
class Row extends MapMixin<String, dynamic>
    with UnmodifiableMapMixin<String, dynamic> {
  final QueryResult _result;
  final int _rowIndex;

  Row._(this._result, this._rowIndex);

  /// Returns the value stored in the [i]-th column in this row (zero-indexed).
  dynamic columnAt(int i) {
    return _result.rows[_rowIndex][i];
  }

  @override
  operator [](Object key) {
    if (key is! String) return null;

    final index = _result._calculatedIndexes[key];

    if (index == null) return null;

    return columnAt(index);
  }

  @override
  Iterable<String> get keys => _result.columnNames;
}

class _ResultIterator extends Iterator<Row> {
  final QueryResult result;
  int index = -1;

  _ResultIterator(this.result);

  @override
  Row get current => Row._(result, index);

  @override
  bool moveNext() {
    index++;
    return index < result.rows.length;
  }
}
