import 'package:flutter_test/flutter_test.dart';
import 'package:nappy_mobile/common/exceptions/value_exceptions.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/password_value.dart';

void main() {
  group("Value objects make illegal state unrepresentable", () {
    const String validEmail = "example@email.com";
    const String emptyEmail = "";
    const String invalidEmail = "thiswillnot.work";
    test("EmailAddressValue makes invalid email unrepresentable", () {
      expect(EmailAddressValue(validEmail), isA<EmailAddressValue>());
      expect(() => EmailAddressValue(emptyEmail), throwsA(isA<RequiredValueException>()));
      expect(() => EmailAddressValue(invalidEmail), throwsA(isA<IllegalValueException>()));
    });

    test("PasswordValue makes invalid password unrepresentable", () {
      // Password requirements: Length >= 6
      const String validPassword = "123456";
      const String emptyPassword = "";
      const String invalidPassword = "abcd1";
      expect(PasswordValue(validPassword), isA<PasswordValue>());
      expect(() => PasswordValue(emptyPassword), throwsA(isA<RequiredValueException>()));
      expect(() => PasswordValue(invalidPassword), throwsA(isA<TooShortValueException>()));
    });
  });
}
