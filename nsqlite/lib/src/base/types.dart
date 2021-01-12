import 'package:nsqlite/src/interfaces/column.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

abstract class DataType<T> implements ColumnCreator<T>, SQLFieldRelatedObject {
  final String name;
  final bool hasSize;
  final bool hasDecimals;
  bool defaultForType;

  Type get type;

  DataType(this.name,
      {this.hasSize = false,
      this.hasDecimals = false,
      this.defaultForType = true});
}

class DataTypes {
  DataTypes._();

  static DataTypes _instance;

  factory DataTypes(List<DataType> types) {
    _instance ??= DataTypes._();

    if (_instance._types.isEmpty) {
      _instance._types.addAll(types);
    }
    return _instance;
  }

  List<DataType> _types = List<DataType>();

  List<DataType> get types => List<DataType>.unmodifiable(_types);

  void registerType(DataType dataType) {
    if (!_types.contains(dataType)) {
      var sameTypes = _types.where((d) => d.type == dataType.type);
      if (sameTypes.isEmpty) {
        dataType.defaultForType = true;
      } else {
        if (dataType.defaultForType) {
          sameTypes.forEach((d) => d.defaultForType = false);
        }
      }
      _types.add(dataType);
    }
  }
}
