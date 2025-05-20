import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:recipe_box/features/premium_page/premium_manager.dart';

class PremiumAppBar extends ConsumerWidget {
  const PremiumAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerInfo = ref.watch(customerInfoProvider);
    if (customerInfo.hasValue) {
      print("888888888888");
      print(customerInfo.value!.entitlements.toJson()["active"]);
      print("888888888888");
      print(customerInfo.value!.entitlements.toJson());
      print("888888888888");
    }

    return AppBar(
      centerTitle: true,
      title: customerInfo.when(
        data: (info) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(Icons.arrow_back_rounded),
              style: IconButton.styleFrom(iconSize: 56),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: CustomerInfoDisplay(
                premiumActive:
                    (customerInfo.value!.entitlements.toJson()["active"] !=
                        null),
                //premiumActive: customerInfo.value!.entitlements.toJson()[""],
              ),
            ),
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

class CustomerInfoDisplay extends StatelessWidget {
  final bool premiumActive;
  const CustomerInfoDisplay({required this.premiumActive, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    fontWeight: FontWeight.normal,
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
