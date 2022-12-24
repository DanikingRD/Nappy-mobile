import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/errors.dart';
import 'package:nappy_mobile/value_objects.dart';

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