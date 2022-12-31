import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/common/exceptions/backend_error_mapping.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/password_value.dart';
import 'package:nappy_mobile/models/user.dart' as model;
import 'package:nappy_mobile/repositories/impl/user_repository.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';
import 'package:nappy_mobile/repositories/interfaces/user_facade.dart';

final authRepositoryProvider = Provider<IAuthRepositoryFacade>((ref) {
  final auth = ref.read(authProvider);
  final google = ref.read(googleProvider);
  final iface = ref.read(userRepositoryProvider);
  return AuthRepositoryImpl(
    firebaseAuth: auth,
    googleSignIn: google,
    userInterface: iface,
  );
});

final authUpdateProvider = StreamProvider((ref) {
  return ref.read(authRepositoryProvider).onUserAuthUpdate();
});

class AuthRepositoryImpl implements IAuthRepositoryFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;
  final IUserFacade _userInterface;

  const AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required IUserFacade userInterface,
  })  : _firebaseAuth = firebaseAuth,
        _googleAuth = googleSignIn,
        _userInterface = userInterface;

  /// Calls the repository sign up method and saves the user
  /// on the database.
  @override
  AsyncAuthResult<Unit> register({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      if (credentials.user == null) {
        return left(AuthError.unknown);
      }
      // Create user record in the database
      final Identifier id = credentials.user!.toIdentifier();
      final model.User user = model.User(email: email.value, id: id);
      final result = await _userInterface.create(user);
      return result.match(
        (error) => left(error),
        (_) => right(unit),
      );
    } on FirebaseException catch (e) {
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
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
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
    }
  }

  @override
  AsyncAuthResult<Identifier> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        final creds = await _firebaseAuth.signInWithPopup(provider);
        if (creds.user == null) {
          return left(AuthError.unknown);
        }
        final identifier = creds.user!.toIdentifier();
        return right(identifier);
      } else {
        final user = await _googleAuth.signIn();
        if (user == null) {
          return left(AuthError.unknown);
        }
        final auth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );
        final userCredential = await _firebaseAuth.signInWithCredential(credential);
        if (userCredential.user == null) {
          return left(AuthError.unknown);
        }
        final identifier = userCredential.user!.toIdentifier();
        return right(identifier);
      }
    } on FirebaseException catch (e) {
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
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
    } on FirebaseException catch (e) {
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
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
