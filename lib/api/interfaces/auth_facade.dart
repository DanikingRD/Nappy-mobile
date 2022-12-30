import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/error/auth_error.dart';
import 'package:nappy_mobile/common/user.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/password_value.dart';

/// Represents an Authentication Repository.
abstract class IAuthRepositoryFacade {
  Future<Either<AuthError, Unit>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> sendResetPasswordLink(EmailAddressValue email);

  Future<Either<AuthError, Unit>> signInWithGoogle();

  Stream<Option<UserIdentifier>> onAuthStateChanged();

  Option<UserIdentifier> getUserIdentifier();

  Future<void> signOut();
}
