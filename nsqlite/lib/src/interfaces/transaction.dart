/// A [Transaction] that can be commited or rolled back
abstract class Transaction {
  bool inTransaction();

  /// Completes the transaction. No further queries may be sent to to this
  /// [QueryExecutor] after this method was called.
  void commit();

  /// Cancels this transaction. No further queries may be sent ot this
  /// [QueryExecutor] after this method was called.
  void rollback();
}
