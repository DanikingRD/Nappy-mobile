import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/value/email_address_value.dart';
import 'package:nappy_mobile/value/password_value.dart';

/// Represents an Authentication Repository.
/// Feel free to further extend this.
abstract class IAuthRepository {
  Future<Either<AuthError, void>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  // Future<Either<AuthError, Unit>> registerWithEmail({
  //   required EmailAddressValue email,
  //   required PasswordValue password,
  // });

  // Future<Either<AuthError, Unit>> signInWithEmail({
  //   required EmailAddressValue email,
  //   required PasswordValue password,
  // });

  // Future<Either<AuthError, Unit>> signInWithGoogle();
}
