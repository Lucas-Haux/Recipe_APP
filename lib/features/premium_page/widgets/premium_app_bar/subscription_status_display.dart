import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubscriptionStatusDisplay extends StatelessWidget {
  final bool premiumActive;

  const SubscriptionStatusDisplay({required this.premiumActive, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 156, 134, 244),
            Color.fromARGB(255, 226, 134, 244),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(3), // Border thickness
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Premium: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: premiumActive ? "Active" : "Inactive",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: premiumActive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
