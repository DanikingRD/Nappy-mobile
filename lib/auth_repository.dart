import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/global_providers.dart';
import 'package:nappy_mobile/user.dart';
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
  Future<Either<AuthError, Unit>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    }
  }

  @override
  Future<Either<AuthError, Unit>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    }
  }

  @override
  Future<Either<AuthError, Unit>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _firebaseAuth.signInWithPopup(provider);
        return right(unit);
      } else {
        final user = await _googleAuth.signIn();
        final auth = await user?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: auth?.accessToken,
          idToken: auth?.idToken,
        );
        final userCredential = _firebaseAuth.signInWithCredential(credential);
        return right(unit);
      }
    } on FirebaseException catch (e) {
      
      return left(AuthErrorHelper.getByCode(e.code));
    } catch (e) {
      return left(AuthError.serverError);
    }
  }

  @override
  Stream<Option<UserIdentifier>> onAuthStateChanged() {
    final authStates = _firebaseAuth.authStateChanges();
    return authStates.map((event) {
      if (event == null) {
        return Option.none();
      }
      final id = UserIdentifier(id: event.uid);
      return Option.of(id);
    });
  }
}
