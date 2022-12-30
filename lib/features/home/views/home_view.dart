import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/common/widgets/primary_button.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Text('Home View'),
          PrimaryButton(
            text: "Sign Out",
            onPressed: () async {
//final nav = Navigator.of(context);
              await ref.read(authProvider).signOut();
              // nav.pop();
            },
          )
        ],
      ),
    );
  }
}
