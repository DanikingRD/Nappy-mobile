import 'package:nappy_mobile/value_objects.dart';

abstract class IAuthRepository {
  Future<void> registerWithEmailAndPassword({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<void> signInWithEmailAndPassword({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  Future<void> signInWithGoogle();
}
