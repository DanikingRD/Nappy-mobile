abstract class ValueException<T> implements Exception {
  final T? value;
  final String code;
  final String message;

  const ValueException({
    required this.value,
    required this.code,
    required this.message,
  });

  @override
  String toString() {
    return "$code: $message";
  }
}

/// Thrown is a value is empty or null.
class RequiredValueException<T> extends ValueException<T> {
  const RequiredValueException()
      : super(value: null, code: "required", message: "Value is required.");
}

/// Thrown is a value has an illegal state, in other words an invalid value.
class IllegalValueException<T> extends ValueException<T> {
  const IllegalValueException(T val)
      : super(
          value: val,
          code: "illegal-value",
          message: "Illegal Value",
        );
}


class TooShortValueException<T> extends ValueException<T> {
  const TooShortValueException(T val)
      : super(value: val, code: 'short', message: 'Value is too short.');

  @override
  String toString() {
    return 'Value is too short: $message';
  }
}
