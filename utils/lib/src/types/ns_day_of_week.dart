import 'package:utils/utils.dart';

class NSDayOfWeek implements Comparable<NSDayOfWeek> {
  static const int domingo = 1;
  static const int segunda = 2;
  static const int terca = 3;
  static const int quarta = 4;
  static const int quinta = 5;
  static const int sexta = 6;
  static const int sabado = 7;
  static const int diasPorSemana = 7;

  int _value;

  NSDayOfWeek({int value, NSDateTime dateTime}) :
    assert((value == null && dateTime != null) || (value != null || dateTime == null)) {
      if(value = null) {
        _setValue(value);
      }
      else {
        _setValue(valueFromDateTime(dateTime));
      }
  }

  void _setValue(int value) {
    if(value < domingo || value > sabado || value == null) {
      throw ArgumentError("Dia da semana " + (value == null ? "null" : value) + " não existente.");
    }
    else {
      this._value = value;
    }
  }

  bool operator ==(Object other) {
    if(other == null || this.value == null) {
      return false;
    }
    else if(other is int) {
      return this.value == other;
    }
    else if(other is NSDayOfWeek) {
      return this.value == null || other.value == null ? false : this.value == other.value;
    }
    else {
      return false;
    }
  }

  bool operator <(NSDayOfWeek other) {
    return (this.value == null || other == null || other.value == null) ? null : this.value < other.value;
  }

  bool operator <=(NSDayOfWeek other) {
    return (this.value == null || other == null || other.value == null) ? null : this.value <= other.value;
  }

  bool operator >(NSDayOfWeek other) {
    return (this.value == null || other == null || other.value == null) ? null : this.value > other.value;
  }

  bool operator >=(NSDayOfWeek other) {
    return (this.value == null || other == null || other.value == null) ? null : this.value >= other.value;
  }

  NSDayOfWeek operator +(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value + other.value);
  }

  NSDayOfWeek operator -(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value - other.value);
  }

  NSDayOfWeek operator *(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value * other.value);
  }

  NSDayOfWeek operator /(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value / other.value as int);
  }

  NSDayOfWeek operator ~/(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value ~/ other.value);
  }

  NSDayOfWeek operator %(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value % other.value);
  }

  NSDayOfWeek remainder(NSDayOfWeek other) {
    return NSDayOfWeek(value: (this.value == null || other == null || other.value == null) ? null : this.value.remainder(other.value));
  }

  NSDayOfWeek abs() {
    return this.value == null ? null : NSDayOfWeek(value: this.value.abs());
  }

  int get hashCode {
    return value == null ? null : value.hashCode;
  }

  static int valueFromDateTime(NSDateTime dateTime) {
    if(dateTime == null) {
      return null;
    }

    switch(dateTime.value.weekday) {
      case DateTime.sunday:
        return domingo;
      case DateTime.monday:
        return segunda;
      case DateTime.tuesday:
        return terca;
      case DateTime.wednesday:
        return quarta;
      case DateTime.thursday:
        return quinta;
      case DateTime.friday:
        return sexta;
      case DateTime.saturday:
        return sabado;
      default:
        return null;
    }
  }

  int get value {
    return _value;
  }

  static NSDayOfWeek fromDateTime(NSDateTime dateTime) {
    return NSDayOfWeek(value: valueFromDateTime(dateTime));
  }

  @override
  int compareTo(NSDayOfWeek other) {
    return other == null ? 1 : value.compareTo(other.value);
  }
}