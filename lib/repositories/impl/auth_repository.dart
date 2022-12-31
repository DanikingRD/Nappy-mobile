import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/common/exceptions/auth_exceptions.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/password_value.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';

final authRepositoryProvider = Provider<IAuthRepositoryFacade>((ref) {
  final auth = ref.read(authProvider);
  final google = ref.read(googleProvider);
  return AuthRepositoryImpl(
    firebaseAuth: auth,
    googleSignIn: google,
  );
});

final authUpdateProvider = StreamProvider((ref) {
  return ref.read(authRepositoryProvider).onUserAuthUpdate();
});

class AuthRepositoryImpl implements IAuthRepositoryFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  const AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleAuth = googleSignIn;
  @override
  Future<Either<AuthExceptionOutput, Unit>> register({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      return right(unit);
    } on FirebaseException catch (e) {
      return left(AuthException.mapCode(e.code));
    } catch (e) {
      return left(AuthExceptionOutput.serverError);
    }
  }

  @override
  Future<Either<AuthExceptionOutput, Unit>> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      return right(unit);
    } on FirebaseException catch (e) {
      return left(AuthException.mapCode(e.code));
    } catch (e) {
      return left(AuthExceptionOutput.serverError);
    }
  }

  @override
  Future<Either<AuthExceptionOutput, Unit>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _firebaseAuth.signInWithPopup(provider);
        return right(unit);
      } else {
        final user = await _googleAuth.signIn();
        if (user == null) {
          return left(AuthExceptionOutput.canceledByUser);
        }
        final auth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );
        final userCredential = _firebaseAuth.signInWithCredential(credential);
        return right(unit);
      }
    } on FirebaseException catch (e) {
      return left(AuthException.mapCode(e.code));
    } catch (e) {
      return left(AuthExceptionOutput.serverError);
    }
  }

  @override
  Stream<Option<Identifier>> onUserAuthUpdate() {
    final authStates = _firebaseAuth.authStateChanges();
    return authStates.map((event) {
      return Option.fromPredicateMap<User?, Identifier>(
        event,
        (user) => user != null,
        (user) => Identifier.fromUUID(user!.uid),
      );
    });
  }

  @override
  Future<Either<AuthExceptionOutput, Unit>> sendResetPasswordLink(EmailAddressValue email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.value);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthException.mapCode(e.code));
    } catch (e) {
      return left(AuthExceptionOutput.serverError);
    }
  }

  @override
  Option<Identifier> getUserIdentifier() {
    final user = _firebaseAuth.currentUser;
    final userMap = Option.fromPredicateMap<User?, Identifier>(
      user,
      (user) => user != null,
      (user) => Identifier.fromUUID(user!.uid),
    );
    return userMap;
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleAuth.signOut(),
    ]);
  }
}
