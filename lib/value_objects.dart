import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/errors.dart';
import 'package:nappy_mobile/non_null_value.dart';
import 'package:nappy_mobile/validator.dart';

class PasswordValue extends NonNullValue<String> {
  final Either<ValueError<String>, String> val;

  factory PasswordValue(String raw) {
    return PasswordValue._(Validator.validatePassword(raw));
  }

  const PasswordValue._(this.val);

  @override
  Either<ValueError<String>, String> get value => val;
}

class EmailAddressValue extends NonNullValue<String> {
  final Either<ValueError<String>, String> val;

  factory EmailAddressValue(String raw) {
    return EmailAddressValue._(Validator.validateEmail(raw));
  }

  const EmailAddressValue._(this.val);

  @override
  Either<ValueError<String>, String> get value => val;
}
