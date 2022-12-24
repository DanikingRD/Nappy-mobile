import 'package:flutter_backend_utils/errors.dart';
import 'package:flutter_backend_utils/value_objects.dart';
import 'package:fpdart/fpdart.dart';

/// Represents an Authentication Repository.
/// Feel free to further extend this.
abstract class IAuthRepository {
  Future<Either<AuthError, Unit>> registerWithEmailAndPassword({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signInWithEmailAndPassword({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<Either<AuthError, Unit>> signInWithGoogle();
}
