class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "message fetching failed");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "bad request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
      : super(message, "unauthorised exception");
}

class InvalidInputException extends AppException {
  InvalidInputException(message)
      : super(message, "invalid input");
}
