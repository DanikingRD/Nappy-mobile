import 'package:flutter_backend_utils/flutter_backend_utils.dart';
import 'package:flutter_backend_utils/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Making Illegal State Unrepresentable", () {
    test("Given an illegal email address you get an error", () {
      var email = EmailAddressValue("invalid.address");
      expect(email.value, isA<Failure<String>>());
      email = EmailAddressValue("valid@email.com");
      expect(email.val, isA<Success<String>>());
    });

    test("Given an invalid password you get an error", () {
      var password = PasswordValue("notstrongenough", 16);
      expect(password.value, isA<Failure<String>>());
      password = PasswordValue("123456");
      expect(password.val, isA<Success<String>>());
    });

    test("Illegal States give you an invalid value", () {
      final email = EmailAddressValue("not_valid-email.com");
      expect(() => email.getOrThrow(), throwsA(const TypeMatcher<IllegalValueError>()));

      final password = PasswordValue("12345");
      expect(() => password.getOrThrow(), throwsA(const TypeMatcher<IllegalValueError>()));
    });
  });
}
