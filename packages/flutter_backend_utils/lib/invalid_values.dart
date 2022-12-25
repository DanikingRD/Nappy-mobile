class InvalidValue<T> {
  final T error;
  InvalidValue({
    required this.error,
  });
}

class IllegalValueError extends Error {
  final InvalidValue value;
  IllegalValueError(this.value);

  @override
  String toString() {
    const msg = "An InvalidValue was encountered.";
    return Error.safeToString("$msg Invalid value was: $value");
  }
}

class InvalidEmailValue extends InvalidValue<String> {
  InvalidEmailValue(String error) : super(error: error);
}

class InvalidPasswordLengthValue extends InvalidValue<String> {
  InvalidPasswordLengthValue(String error) : super(error: error);
}

enum AuthError {
  invalidEmail,
  wrongPassword,
  userDisabled,
  userNotFound,
  serverError,
}
