// ignore_for_file: unnecessary_string_escapes

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/errors.dart';
import 'package:nappy_mobile/validator.dart';

typedef Success<T> = Right<ValueError<String>, String>;
typedef Error<T> = Left<ValueError<String>, String>;

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
        expect(Validator.validateEmail(entry), isA<Error<String>>());
      }
    });
  
    test("Password must be at least 6 characters long", () {
      const superStrongPassword = "123456";
      const invalidPassword = "i2345";
      expect(Validator.validatePassword(superStrongPassword), isA<Success<String>>());
      expect(Validator.validateEmail(invalidPassword), isA<Error<String>>());
    });
  });
}
