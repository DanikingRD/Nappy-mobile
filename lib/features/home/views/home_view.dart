import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/widgets/primary_button.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).getOrThrow();
    return Scaffold(
      body: ListView(
        children: [
          Text('Home View'),
          Text("Email: ${user.email}"),
          PrimaryButton(
            text: "Sign Out",
            onPressed: () async {
              await ref.read(authProvider).signOut();
              // nav.pop();
            },
          )
        ],
      ),
    );
  }
}
