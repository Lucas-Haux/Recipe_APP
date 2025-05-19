import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/features/premium_page/premium_manager.dart';
import 'package:recipe_box/features/premium_page/widgets/deal_card.dart';
import 'package:recipe_box/features/premium_page/widgets/premium_card.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(premiumManagerProvider.notifier);

    final state = ref.watch(premiumManagerProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            PremiumCard(),
            Spacer(),
            DealCard(),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
