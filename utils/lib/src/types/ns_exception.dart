class NSException implements Exception {
  String message;

  NSException([this.message = ""]);

  String toString() => 'NSException: $message';
}