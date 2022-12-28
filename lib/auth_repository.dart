import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/global_providers.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/util/auth_interface.dart';
import 'package:nappy_mobile/value/email_address_value.dart';
import 'package:nappy_mobile/value/password_value.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final auth = ref.read(authProvider);
  final google = ref.read(googleProvider);
  return AuthRepositoryImpl(auth, google);
});

class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  const AuthRepositoryImpl(this._firebaseAuth, this._googleAuth);

  @override
  Future<Either<AuthError, void>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    }
  }

  @override
  Future<Either<AuthError, void>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    }
  }
}
