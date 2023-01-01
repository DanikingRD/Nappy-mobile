import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Align(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: NappyColors.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: textTheme.bodyText1!.copyWith(
                    color: const Color(0xff5C5C5C),
                  ),
                ),
                Text(
                  amount,
                  style: textTheme.bodyText1!.copyWith(
                    color: NappyColors.dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
