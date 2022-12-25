import 'package:flutter_backend_utils/types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_backend_utils/validator.dart';

void main() {
  group("Validator Test", () {
    test("Given a valid email you get a success", () {
      const validEmails = ["admin@mailserver1", "example_this-works@localhost", "user@localserver"];
      for (final entry in validEmails) {
        expect(Validator.validateEmail(entry), isA<Success<String>>());
      }
    });

    test("Given an invalid email you get an error", () {
      const invalidEmails = [
        "Abc.example.com",
        'a\"b(c)d,e:f;g<h>i[j\\k]l@example.com',
        "this..is-not@right",
        "it\just;wont=work@notallowed"
      ];
      for (final entry in invalidEmails) {
        expect(Validator.validateEmail(entry), isA<Failure<String>>());
      }
    });

    test("Password must be at least N characters long", () {
      const superStrongPassword = "123456";
      const invalidPassword = "i2345";
      // Defaults to 6
      expect(Validator.validatePassword(superStrongPassword), isA<Success<String>>());
      expect(Validator.validateEmail(invalidPassword), isA<Failure<String>>());
      // It is now valid because we have decreased the min length.
      expect(Validator.validatePassword(invalidPassword, 4), isA<Success<String>>());
    });
  });
}
