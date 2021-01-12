class NSBoolean {
  bool value;

  NSBoolean({bool b, NSBoolean ns}) : assert((b != null && ns == null) || (b == null && ns != null))
  {
    if(b != null) {
      this.value = b;
    } else {
      this.value = ns.value;
    }
  }

  bool operator ==(Object other) {
    return this.value == other;
  }

  int get hashCode {
    return value == null ? null : value.hashCode;
  }
}