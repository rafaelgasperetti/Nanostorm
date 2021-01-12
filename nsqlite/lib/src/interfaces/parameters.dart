import 'dart:typed_data';

abstract class Parameters<T> {
  Parameters(T statement);

  void bindBlob(int index, Uint8List value);

  void bindString(int index, String value);

  void bindDouble(int index, double value);

  void bindInt(int index, int value);

  void bindInt32(int index, int value);

  void bindInt64(int index, int value);

  void bindDynamic(int index, dynamic value);

  void bindNull(int index);

  void bind(List<dynamic> params);

  void bindNamed(Map<String, dynamic> params);

  int index(String name);

  String name(int paramIndex);

  void release();
}
