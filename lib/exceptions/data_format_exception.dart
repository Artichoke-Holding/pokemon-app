class DataFormatException implements Exception {
  final String message;
  DataFormatException(this.message);

  @override
  String toString() => 'DataFormatException: $message';
}