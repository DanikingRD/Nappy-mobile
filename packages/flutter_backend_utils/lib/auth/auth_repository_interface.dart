import 'package:flutter_backend_utils/auth/user.dart';
import 'package:flutter_backend_utils/invalid_values.dart';
import 'package:flutter_backend_utils/value_objects.dart';
import 'package:fpdart/fpdart.dart';

/// Represents an Authentication Repository.
/// Feel free to further extend this.
abstract class IAuthRepository {
  Option<UserIdentifier> getUser();

  Future<void> signOut();

  Future<Either<AuthError, Unit>> registerWithEmail({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signInWithEmail({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signInWithGoogle();
}
