import 'package:nappy_mobile/exceptions/value_exceptions.dart';
import 'package:nappy_mobile/value/value.dart';

class PasswordValue extends Value<String> {
  static const int passwordLengthRequired = 6;

  factory PasswordValue(String? raw) {
    if (raw == null || raw.isEmpty) {
      throw const RequiredValueException();
    } else if (raw.length < passwordLengthRequired) {
      throw TooShortValueException(raw);
    } else {
      return PasswordValue._(raw);
    }
  }

  const PasswordValue._(super.value);
}
