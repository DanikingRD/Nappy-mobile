class ValueError<T> {
  final T error;
  ValueError({
    required this.error,
  });
}

class InvalidEmailError extends ValueError<String> {
  InvalidEmailError(String error) : super(error: error);
}

class PasswordLengthError extends ValueError<String> {
  PasswordLengthError(String error) : super(error: error);
}
