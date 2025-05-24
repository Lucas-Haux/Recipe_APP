import 'package:flutter/material.dart';

import 'package:recipe_box/shared/themes/colors.dart';

class TimeRemainingDisplay extends StatelessWidget {
  final String? expirationDate;

  const TimeRemainingDisplay({required this.expirationDate, super.key});

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now().toLocal();
    final dateExpiration = DateTime.parse(expirationDate ?? '').toLocal();

    Duration difference = dateExpiration.difference(dateNow);
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;
    Map diffMap = {
      "Days": days,
      "Hours": hours,
      "Minutes": minutes,
      "Seconds": seconds,
    };

    final diffTypeList = diffMap.entries
        .map((entry) {
          if (entry.value > 0) {
            return Text(
              ' ${entry.value} ${entry.key} ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            );
          } else {
            return null;
          }
        })
        .nonNulls
        .toList();

    return InkWell(
      child: Container(
        width: 186,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: PremiumColors.darkPurple,
        ),
        child: difference.isNegative
            ? Text(
                'EXPIRED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Column(
                children: [
                  Text(
                    'Time Remaining:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  if (diffTypeList.isNotEmpty) diffTypeList[0],
                  if (diffTypeList.length >= 2) diffTypeList[1],
                ],
              ),
      ),
    );
  }
}
