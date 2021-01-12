extension IterableNullable<E> on Iterable<E> {
  E get firstOrNull {
    var it = iterator;
    if (!it.moveNext()) {
      return null;
    }
    return it.current;
  }

  E get lastOrNull {
    var it = iterator;
    if (!it.moveNext()) {
      return null;
    }
    return it.current;
  }

  bool equals(Iterable<E> other) =>
      identical(this, other) ||
      this.runtimeType == other.runtimeType &&
          this.length == other.length &&
          this.every(other.contains);
}
