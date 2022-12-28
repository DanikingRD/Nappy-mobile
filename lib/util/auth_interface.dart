import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/user.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/value/email_address_value.dart';
import 'package:nappy_mobile/value/password_value.dart';

/// Represents an Authentication Repository.
/// Feel free to further extend this.
abstract class IAuthRepository {
  Future<Either<AuthError, Unit>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signInWithGoogle();

  Stream<Option<UserIdentifier>> onAuthStateChanged();
}
