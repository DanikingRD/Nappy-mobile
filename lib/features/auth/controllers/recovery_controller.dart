import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/util/connection.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/value_helper.dart';

final recoveryControllerProvider = StateNotifierProvider.autoDispose<RecoveryController, bool>(
  (ref) {
    return RecoveryController(
      logger: NappyLogger.getLogger((RecoveryController).toString()),
    );
  },
  name: (RecoveryController).toString(),
);

class RecoveryController extends StateNotifier<bool> {
  final NappyLogger _logger;
  RecoveryController({
    required NappyLogger logger,
  })  : _logger = logger,
        super(false);

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
    // TODO: send recovery link
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
