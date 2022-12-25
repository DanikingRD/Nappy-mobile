import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_backend_utils/flutter_backend_utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';


class NappyAuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  const NappyAuthRepository(this._firebaseAuth, this._googleAuth);

  @override
  Option<UserIdentifier> getUser() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return Option.none();
    }
    final identifier = UserIdentifier(id: user.uid);
    return Option.of(identifier);
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, Unit>> registerWithEmail({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    final emailAddr = email.getOrThrow();
    final pw = password.getOrThrow();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddr,
        password: pw,
      );
      return right(unit);
    } on PlatformException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return left(AuthError.invalidEmail);
        case "user-disabled":
          return left(AuthError.userDisabled);
        case "user-not-found":
          return left(AuthError.userNotFound);
        case "wrong-password":
          return left(AuthError.wrongPassword);
      }
      return left(AuthError.serverError);
    }
  }

  @override
  Future<Either<AuthError, Unit>> signInWithEmail({
    required EmailAddressValue email,
    required PasswordValue password,
  }) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthError, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
