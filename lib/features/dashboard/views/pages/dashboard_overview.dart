import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/dashboard/views/widgets/summary_card.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // This column positions the child row at the top of the view
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 20.0,
                children: const [
                  SummaryCard(
                    icon: Icons.credit_card,
                    title: "Devices",
                    count: 123,
                  ),
                  SummaryCard(
                    icon: Icons.people,
                    title: "Contacts",
                    count: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
