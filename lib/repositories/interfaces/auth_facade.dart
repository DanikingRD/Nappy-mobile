import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/exceptions/backend_error_mapping.dart';
import 'package:nappy_mobile/common/util/types.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/password_value.dart';

/// Represents the result of an authentication request.
typedef AsyncAuthResult<T> = FutureResult<BackendError, T>;

/// Represents an Authentication Repository.
abstract class IAuthRepositoryFacade {
  AsyncAuthResult<Unit> register({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  AsyncAuthResult<Unit> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
  });

  AsyncAuthResult<Unit> sendResetPasswordLink(EmailAddressValue email);

  AsyncAuthResult<Identifier> signInWithGoogle();

  Stream<Option<Identifier>> onUserAuthUpdate();

  Option<Identifier> getUserIdentifier();

  Future<void> signOut();
}
