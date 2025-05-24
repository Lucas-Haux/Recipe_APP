import 'package:flutter/material.dart';

import 'package:recipe_box/features/premium_page/premium_manager.dart';

import 'package:recipe_box/features/premium_page/widgets/premium_app_bar/subscription_info_button/subscription_info_button.dart';
import 'package:recipe_box/features/premium_page/widgets/premium_app_bar/subscription_status_display.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumAppBar extends ConsumerWidget {
  const PremiumAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerInfo = ref.watch(customerInfoNotifierProvider);
    final bool premiumActive =
        customerInfo.value?.entitlements.all['premium']?.isActive ?? false;

    return AppBar(
      centerTitle: true,
      title: customerInfo.when(
        data: (info) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),

            //BackButton
            IconButton(
              onPressed: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/'),
              },
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              style:
                  IconButton.styleFrom(iconSize: 40, padding: EdgeInsets.zero),
            ),

            Spacer(),

            // Status Display
            SubscriptionStatusDisplay(
              premiumActive: premiumActive,
            ),

            Spacer(),

            // Info Button
            SubscriptionInfoButton(
              customerInfo: customerInfo.value!,
              premiumActive: premiumActive,
            ),

            Spacer(flex: 2),
          ],
        ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => CircularProgressIndicator(),
      ),
      leading: SizedBox.shrink(),
      leadingWidth: 0,
    );
  }
}
