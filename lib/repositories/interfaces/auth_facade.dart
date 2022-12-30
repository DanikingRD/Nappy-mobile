import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/exceptions/auth_exceptions.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/password_value.dart';

/// Represents an Authentication Repository.
abstract class IAuthRepositoryFacade {
  Future<Either<AuthExceptionOutput, Unit>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthExceptionOutput, Unit>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthExceptionOutput, Unit>> sendResetPasswordLink(EmailAddressValue email);

  Future<Either<AuthExceptionOutput, Unit>> signInWithGoogle();

  Stream<Option<Identifier>> onUserAuthUpdate();

  Option<Identifier> getUserIdentifier();

  Future<void> signOut();
}
