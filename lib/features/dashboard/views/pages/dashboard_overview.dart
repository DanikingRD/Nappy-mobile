import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/dashboard/views/widgets/summary_card.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SummaryCard(
      icon: Icons.credit_card,
      title: "Devices",
      amount: "123",
    );
  }
}
