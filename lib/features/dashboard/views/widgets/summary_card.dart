import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            spreadRadius: 3.0,
            color: Colors.grey.shade300,
            offset: const Offset(0.0, 2.0),
          )
        ],
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
                size: 35,
              ),
            ),
          ),
          const SizedBox(
            width: 36,
          ),
          Column(
            children: [
              Text(
                title,
                style: textTheme.bodyText1!.copyWith(
                  color: const Color(0xff5C5C5C),
                  fontSize: 18,
                ),
              ),
              Text(
                count.toString(),
                style: textTheme.bodyText1!.copyWith(
                  color: NappyColors.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
