import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 

    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            Text("Sign in"),
            TextFormField(
              decoration: InputDecoration(filled: true),
            ),
            TextFormField(
              decoration: InputDecoration(filled: true),
            ),
          ],
        ),
      ),
    );
  }
}
