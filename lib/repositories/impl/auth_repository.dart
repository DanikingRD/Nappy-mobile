import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/common/exceptions/auth_exceptions.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/types.dart';
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
  AsyncAuthResult<Identifier> register({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      if (credentials.user == null) {
        return left(AuthExceptionOutput.unknownError);
      }
      final Identifier id = credentials.user!.toIdentifier();
      return right(id);
    } on FirebaseException catch (e) {
      return left(AuthException.mapCode(e.code));
    } catch (e) {
      return left(AuthExceptionOutput.unknownError);
    }
  }

  @override
  AsyncAuthResult<Unit> signIn({
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
      return left(AuthExceptionOutput.unknownError);
    }
  }

  @override
  AsyncAuthResult<Unit> signInWithGoogle() async {
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
      return left(AuthExceptionOutput.unknownError);
    }
  }

  @override
  Stream<Option<Identifier>> onUserAuthUpdate() {
    final authStates = _firebaseAuth.authStateChanges();
    return authStates.map((event) {
      return Option.fromPredicateMap<User?, Identifier>(
        event,
        (user) => user != null,
        (user) => user!.toIdentifier(),
      );
    });
  }

  @override
  AsyncAuthResult<Unit> sendResetPasswordLink(EmailAddressValue email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.value);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthException.mapCode(e.code));
    } catch (e) {
      return left(AuthExceptionOutput.unknownError);
    }
  }

  @override
  Option<Identifier> getUserIdentifier() {
    final user = _firebaseAuth.currentUser;
    final idMapping = Option.fromPredicateMap<User?, Identifier>(
      user,
      (user) => user != null,
      (user) => user!.toIdentifier(),
    );
    return idMapping;
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleAuth.signOut(),
    ]);
  }
}
