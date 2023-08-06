class APIException implements Exception {
  String message;
  int? code;
  dynamic parameters;
  APIException(
      {this.message = 'Unknown exception!', this.code, this.parameters});

  String get fullMessage {
    return message;
  }

  @override
  String toString() => fullMessage;
}
