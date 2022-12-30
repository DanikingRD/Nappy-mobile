import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/api/interfaces/auth_facade.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/user.dart';
import 'package:nappy_mobile/common/error/auth_error.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/password_value.dart';

final authRepositoryProvider = Provider<IAuthRepositoryFacade>((ref) {
  final auth = ref.read(authProvider);
  final google = ref.read(googleProvider);
  return AuthRepositoryImpl(auth, google);
});

class AuthRepositoryImpl implements IAuthRepositoryFacade {
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
    } on FirebaseException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    } catch (e) {
      return left(AuthError.serverError);
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
    } on FirebaseException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    } catch (e) {
      return left(AuthError.serverError);
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
        if (user == null) {
          return left(AuthError.canceledByUser);
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

  @override
  Future<Either<AuthError, Unit>> sendResetPasswordLink(EmailAddressValue email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.value);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthErrorHelper.getByCode(e.code));
    } catch (e) {
      return left(AuthError.serverError);
    }
  }

  @override
  Option<UserIdentifier> getUserIdentifier() {
    final user = _firebaseAuth.currentUser;
    final userMap = Option.fromPredicateMap<User?, UserIdentifier>(
      user,
      (user) => user != null,
      (user) => UserIdentifier(id: user!.uid),
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
