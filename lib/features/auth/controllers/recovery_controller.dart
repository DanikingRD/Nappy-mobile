import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/error/auth_error.dart';
import 'package:nappy_mobile/common/util/connection.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/value_helper.dart';
import 'package:nappy_mobile/features/auth/views/widgets/auth_dialogs.dart';
import 'package:nappy_mobile/services/auth_service.dart';

final recoveryControllerProvider = StateNotifierProvider.autoDispose<RecoveryController, bool>(
  (ref) {
    return RecoveryController(
      logger: NappyLogger.getLogger((RecoveryController).toString()),
      service: ref.read(authServiceProvider),
    );
  },
  name: (RecoveryController).toString(),
);

class RecoveryController extends StateNotifier<bool> {
  final NappyLogger _logger;
  final AuthService _service;
  RecoveryController({
    required NappyLogger logger,
    required AuthService service,
  })  : _logger = logger,
        _service = service,
        super(false);

  /// This will try to send a reset password link to the passed in email.
  /// But bad things can happen :P
  Future<Unit> submit(BuildContext context, String rawEmail) async {
    final connection = await handleConnectionError(context);
    if (!connection) {
      return unit;
    }
    final email = ValueHelper.handleEmail(
      context: context,
      email: rawEmail,
      logger: _logger,
    );
    if (email.isNone()) {
      return unit;
    }

    final emailVal = email.getOrThrow();
    setLoading();
    await _service.sendResetPasswordLink(
      onError: (AuthError error) => AuthDialogs.onAuthError(error, context),
      onSuccess: () => AuthDialogs.onEmailVerificationSent(context),
      email: emailVal,
    );
    setIdle();
    return unit;
  }

  void setLoading() {
    state = true;
  }

  void setIdle() {
    state = false;
  }
}
