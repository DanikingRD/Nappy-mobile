import 'package:flutter_backend_utils/non_illegal_value.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_backend_utils/invalid_values.dart';
import 'package:flutter_backend_utils/validator.dart';

/// Represents a non-illegal password typically inputted by the user.
class PasswordValue extends NonIllegalValue<String> {
  final Either<InvalidValue<String>, String> val;

  factory PasswordValue(String raw, [int length = 6]) {
    return PasswordValue._(Validator.validatePassword(raw, length));
  }

  const PasswordValue._(this.val);

  @override
  Either<InvalidValue<String>, String> get value => val;
}

/// Represents a non-illegal email address typically inputted by the user.
class EmailAddressValue extends NonIllegalValue<String> {
  final Either<InvalidValue<String>, String> val;

  factory EmailAddressValue(String raw) {
    return EmailAddressValue._(Validator.validateEmail(raw));
  }

  const EmailAddressValue._(this.val);

  @override
  Either<InvalidValue<String>, String> get value => val;
}
