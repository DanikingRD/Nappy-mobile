import 'package:flutter_test/flutter_test.dart';
import 'package:nappy_mobile/common/util/validator.dart';

void main() {
  group('Validator correctly identifies invalid values', () {
    test('Given an invalid email the Validator returns false', () {
      expect(Validator.validateEmail(""), false);
      expect(Validator.validateEmail("bad_email.com"), false);
      expect(Validator.validateEmail("this_should@work.me"), true);
    });
  });
}
