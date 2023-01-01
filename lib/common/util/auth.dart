import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/exceptions/backend_error_mapping.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';

Future<void> setActiveUser(
  Ref ref,
  Identifier id, {
  void Function(User user)? success,
  void Function(BackendError error)? error,
}) async {
  final data = await ref.watch(userRepositoryProvider).read(id);
  data.match(
    (err) => error?.call(err),
    (user) {
      ref.watch(userProvider.notifier).update((state) => Option.of(user));
      success?.call(user);
    },
  );
}

Future<void> setActiveUserWidget(
  WidgetRef ref,
  Identifier id, {
  void Function(User user)? success,
  void Function(BackendError error)? error,
}) async {
  final NappyLogger logger = NappyLogger.getLogger('auth');
  final data = await ref.watch(userRepositoryProvider).read(id);
  data.match(
    (err) => error?.call(err),
    (user) {
      logger.i('Setting new active user: ${user.toString()}');
      ref.watch(userProvider.notifier).update((state) => Option.of(user));
      success?.call(user);
    },
  );
}
