import 'package:flutter/material.dart';

import 'package:recipe_box/shared/themes/colors.dart';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class _CustomButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;
  final Color bgColor;
  const _CustomButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.bgColor,
  });
  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => onPressed(),
      icon: Icon(icon, color: Colors.white, size: 22),
      label: Text(label,
          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800)),
      style: FilledButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        fixedSize: Size(184, 48),
      ),
    );
  }
}

class ManageSubscriptionButton extends StatelessWidget {
  final String manageUrl;
  const ManageSubscriptionButton({
    required this.manageUrl,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _CustomButton(
        onPressed: () async {
          final Uri url = Uri.parse(manageUrl);
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $url');
          }
        },
        icon: Symbols.manage_accounts_rounded,
        label: 'Manage Subscription',
        bgColor: PremiumColors.darkPurple,
      ),
    );
  }
}

class RestorePurchaseButton extends StatelessWidget {
  const RestorePurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _CustomButton(
        onPressed: () {
          Purchases.restorePurchases();
        },
        icon: Symbols.cloud_sync_rounded,
        label: 'Restore Purchase',
        bgColor: PremiumColors.lightPurple,
      ),
    );
  }
}
