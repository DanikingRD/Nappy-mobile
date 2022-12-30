/// The validator class contains a set helper functions
/// for validating different types of inputs, mostly text field inputs.
///
/// Test case: `/test/validator_test.dart`
class Validator {
 
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
  static bool validateEmail(String rawEmail) {
    final RegExp regExp = RegExp(
      r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()\.,;\s@\"]+\.{0,1})+[^<>()\.,;:\s@\"]{2,})$',
    );
    return regExp.hasMatch(rawEmail);
  }
}
