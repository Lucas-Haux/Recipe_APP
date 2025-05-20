import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_box/features/premium_page/premium_manager.dart';
import 'package:recipe_box/features/premium_page/widgets/premium_app_bar.dart';
import 'package:recipe_box/features/premium_page/widgets/product_card.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(premiumManagerProvider.notifier);
    final state = ref.watch(premiumManagerProvider);

    return Scaffold(
      appBar:
          PreferredSize(preferredSize: Size(10, 60), child: PremiumAppBar()),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: state.when(
          data: (offering) {
            List<Package> products = offering.availablePackages;
            final List<Map<String, Object>> packagesMetaData =
                (offering.metadata["packages"] as List)
                    .whereType<Map>()
                    .map((e) => Map<String, Object>.from(e))
                    .toList();

            return Column(
              children: [
                Spacer(),
                for (var entry in products.asMap().entries) ...[
                  ProductCard(
                    product: entry.value,
                    clipArt: (entry.key == 0) ? true : false,
                    metaData: packagesMetaData.firstWhere(
                        (map) => map['id'] == entry.value.identifier),
                  ),
                  Spacer()
                  //if (products.length - 1 > entry.key) Spacer(),
                ],
              ],
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
