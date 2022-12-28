import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_controller.dart';

class Startup extends ConsumerWidget {
  const Startup({super.key});

  void fetchUser() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authEvents = ref.watch(authStateChangesProvider);
    return Container();
  }
}
