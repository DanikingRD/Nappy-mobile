// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter_backend_utils/invalid_values.dart';
import 'package:fpdart/fpdart.dart';

/// The validator class contains a set helper functions
/// for validating different types of inputs, mostly text field inputs.
///
/// Test case: `/test/validator_test.dart`
class Validator {
  static const int kPasswordLengthRequired = 6;
  // Don't let anyone instantiate this
  const Validator._();

  /// <p> Validates that the given email address is valid by matching it
  /// against the defined regular expression pattern. </p>>
  /// <b> Email Address structure: </b>
  /// <p> - username@domain </p>
  /// <b> Email Acceptance Criteria: </b>
  /// <p>
  ///
  /// - The username-part cannot contain any of the following characters:
  /// <>()\[\]\.,;:\s@\"
  ///
  /// - Username and domain must be separated by a '@'.
  /// - There can't be any whitespaces
  /// - The domain is not allowed to be empty.
  /// </p>
  ///
  /// <b> Here are some example of valid and invalid emails: </b>
  ///
  /// Valid emails:
  ///
  /// - admin@mailserver1
  /// - example_this-works@localhost
  /// - user@localserver
  ///
  /// Invalid emails:
  /// - Abc.example.com
  /// - this..is-not@right
  /// - it\just;wont=work@notallowed
  static Either<InvalidValue<String>, String> validateEmail(String rawEmail) {
    final RegExp regExp = RegExp(
      r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\.,;\s@\"]+\.{0,1})+[^<>()\.,;:\s@\"]{2,})$',
    );
    if (!regExp.hasMatch(rawEmail)) {
      return left(InvalidEmailValue(rawEmail));
    }
    return right(rawEmail);
  }

  /// Validates the given password.
  ///
  /// <b> Email Acceptance Criteria: </b>
  ///
  /// - The password must be at least 6 characters long.
  ///
  ///<b> Here are some example of valid and invalid passwords: </b>
  ///
  /// Valid passwords:
  ///
  /// - 123456
  /// - abcdefg
  /// - this is a super strong pasword
  ///
  /// Invalid passwords:
  /// - 12345
  /// - abcde
  /// - _A1-4
  static Either<InvalidValue<String>, String> validatePassword(String rawPassword,
      [int len = kPasswordLengthRequired]) {
    if (rawPassword.length < len) {
      return left(InvalidPasswordLengthValue(rawPassword));
    } else {
      return right(rawPassword);
    }
  }
}
