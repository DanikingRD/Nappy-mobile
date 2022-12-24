import 'package:flutter_backend_utils/value_objects.dart';

/// Represents an Authentication Repository.
/// Feel free to further extend this.
abstract class IAuthRepository {
  /// Register generic user with email and password
  Future<void> registerWithEmailAndPassword({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  /// Sign in with Google services.
  Future<void> signInWithGoogle();
}
