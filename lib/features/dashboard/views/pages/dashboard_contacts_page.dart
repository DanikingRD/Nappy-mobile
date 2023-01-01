import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashboardContactsPage extends StatelessWidget {
  const DashboardContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text("This is the contacts page"),
      ],
    );
  }
}
