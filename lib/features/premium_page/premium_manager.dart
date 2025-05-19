import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'premium_manager.g.dart';

@riverpod
class PremiumManager extends _$PremiumManager {
  @override
  Future<Offerings> build() async {
    try {
      Offerings? offerings = await Purchases.getOfferings();

      return offerings;
    } catch (e) {
      throw 'cant get offering $e';
    }
  }
}
