import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nappy_mobile/common/exceptions/backend_error_mapping.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/password_value.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';
import 'package:nappy_mobile/repositories/interfaces/user_facade.dart';

final authRepositoryProvider = Provider<IAuthRepositoryFacade>((ref) {
  final auth = ref.read(authProvider);
  final google = ref.read(googleProvider);
  final iface = ref.read(userRepositoryProvider);
  final logger = NappyLogger.getLogger((AuthRepositoryImpl).toString());
  return AuthRepositoryImpl(
    firebaseAuth: auth,
    googleSignIn: google,
    userInterface: iface,
    logger: logger,
  );
});

final authUpdateProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.onUserAuthUpdate();
});

class AuthRepositoryImpl implements IAuthRepositoryFacade {
  final firebase.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;
  final IUserFacade _userInterface;
  final NappyLogger _logger;

  const AuthRepositoryImpl({
    required firebase.FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required IUserFacade userInterface,
    required NappyLogger logger,
  })  : _firebaseAuth = firebaseAuth,
        _googleAuth = googleSignIn,
        _userInterface = userInterface,
        _logger = logger;

  /// Calls the repository sign up method and saves the user
  /// on the database.
  @override
  AsyncAuthResult<Unit> register({
    required EmailAddressValue email,
    required PasswordValue password,
  }) async {
    try {
      _logger.d('Registering user with email: $email');
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      _logger.d('The user was succesfully registered.');
      if (credentials.user == null) {
        return left(AuthError.unknown);
      }
      final firebaseUser = credentials.user!;
      final model = saveUserRecord(firebaseUser.toIdentifier(), firebaseUser.email!);
      return right(unit);
    } on firebase.FirebaseException catch (e) {
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
      _logger.d('Signing user with email: $email');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      _logger.d('User was succesfully signed in.');
      return right(unit);
    } on firebase.FirebaseException catch (e) {
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
    }
  }

  @override
  AsyncAuthResult<User> signInWithGoogle() async {
    try {
      _logger.d('Signing user with Google provider.');
      final credentials = kIsWeb ? await signInWithGoogleWeb() : await signInWithGoogleMobile();
      if (credentials.user == null) {
        return left(AuthError.unknown);
      }
      // Shouldn't be null anyways
      if (credentials.additionalUserInfo == null) {
        return left(AuthError.unknown);
      }
      if (credentials.user == null) {
        return left(AuthError.unknown);
      }
      final firebaseUser = credentials.user!;
      final Identifier id = firebaseUser.toIdentifier();

      // Create user record
      if (credentials.additionalUserInfo!.isNewUser) {
        return saveUserRecord(id, firebaseUser.email!);
      }
      // Read user
      final User user = await _userInterface.watch(id).first;
      return right(user);
    } on firebase.FirebaseException catch (e) {
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
    }
  }

  Future<firebase.UserCredential> signInWithGoogleWeb() async {
    final provider = firebase.GoogleAuthProvider();
    provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    final credentials = await _firebaseAuth.signInWithPopup(provider);
    return credentials;
  }

  Future<firebase.UserCredential> signInWithGoogleMobile() async {
    final user = await _googleAuth.signIn();
    if (user == null) {
      throw firebase.FirebaseAuthException(
        code: 'sign_in_canceled',
        message: 'popup-closed-by-user',
      );
    }
    final auth = await user.authentication;
    final credential = firebase.GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential;
  }

  @override
  Stream<Option<Identifier>> onUserAuthUpdate() {
    final authStates = _firebaseAuth.authStateChanges();
    final state = authStates.map((event) {
      return Option.fromPredicateMap<firebase.User?, Identifier>(
        event,
        (user) => user != null,
        (user) => user!.toIdentifier(),
      );
    });
    _logger.d('New user authentication state: $state');
    return state;
  }

  @override
  AsyncAuthResult<Unit> sendResetPasswordLink(EmailAddressValue email) async {
    try {
      _logger.d('Attempting the send password reset link to: $email');
      await _firebaseAuth.sendPasswordResetEmail(email: email.value);
      _logger.d('Reset link sent!');
      return right(unit);
    } on firebase.FirebaseException catch (e) {
      return left(AuthError.mapCode(e.code));
    } catch (e) {
      return left(AuthError.unknown);
    }
  }

  @override
  Option<Identifier> getUserIdentifier() {
    final user = _firebaseAuth.currentUser;
    final idMapping = Option.fromPredicateMap<firebase.User?, Identifier>(
      user,
      (user) => user != null,
      (user) => user!.toIdentifier(),
    );
    return idMapping;
  }

  @override
  Future<void> signOut() {
    _logger.d('Attempting to sign out user...');
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleAuth.signOut(),
    ]);
  }

  /// Create a new user record in the database
  AsyncDatabaseResult<User> saveUserRecord(
    Identifier id,
    String email,
  ) async {
    _logger.d('Creating new user record for $email');

    // Email can't be null because we are not dealing with anonymous auth
    final User userModel = User(email: email, id: id);
    final result = await _userInterface.create(userModel);
    return result.match(
      (error) => left(error),
      (_) => right(userModel),
    );
  }
}
