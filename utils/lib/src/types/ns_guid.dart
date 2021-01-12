import 'package:uuid/uuid.dart';

class NSGuid implements Comparable<NSGuid> {
  Uuid _uuid = Uuid();
  List<int> _value;

  NSGuid._({List<int> value}) : assert(value != null) {
    _value = value;
  }

  @override
  String toString() {
    return _uuid.unparse(this._value);
  }

  static NSGuid randomNSGuid() {
    Uuid uuid = Uuid();
    return NSGuid._(value: uuid.parse(uuid.v4()));
  }

  static NSGuid empty() {
    Uuid uuid = Uuid();
    return NSGuid._(value: uuid.parse(Uuid.NAMESPACE_NIL));
  }

  static NSGuid fromString(String value) {
    Uuid uuid = Uuid();
    return NSGuid._(value:  uuid.parse(value));
  }

  @override
  int compareTo(NSGuid other) {
    if(this._value == null && other == null) {
      return 0;
    } else if(this._value == null && other != null) {
      return -1;
    } else if(this._value != null && other == null) {
      return 1;
    } else {
      return _value.toString().compareTo(other.toString());
    }
  }
}