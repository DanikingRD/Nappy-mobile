import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/auth/views/login_view.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child:  Nappy()));
}

class Nappy extends StatelessWidget {
  const Nappy({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
