import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const Nappy());
}

class Nappy extends StatelessWidget {
  const Nappy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: const [
            Text("My App"),
          ],
        ),
      ),
    );
  }
}
