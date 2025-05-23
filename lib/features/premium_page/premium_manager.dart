import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'premium_manager.g.dart';

@riverpod
class PremiumManager extends _$PremiumManager {
  @override
  AsyncValue<Offering> build() {
    getPackages();
    return AsyncLoading();
  }

  Future<void> getPackages() async {
    try {
      Offerings? offerings = await Purchases.getOfferings();
      //List<Package>? packages = offerings.current?.availablePackages;

      //state = AsyncValue.data(packages!);
      state = AsyncValue.data(offerings.current!);
    } catch (e, stackTrace) {
      state = AsyncError('Couldnt Get Packages From The PlayStore', stackTrace);
    }
    await Future.delayed(Duration(seconds: 10));
  }
}

final customerInfoNotifierProvider =
    StateNotifierProvider<CustomerInfoNotifier, AsyncValue<CustomerInfo>>(
        (ref) {
  return CustomerInfoNotifier();
});

class CustomerInfoNotifier extends StateNotifier<AsyncValue<CustomerInfo>> {
  CustomerInfoNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() async {
    try {
      final info = await Purchases.getCustomerInfo();
      state = AsyncValue.data(info);

      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        state = AsyncValue.data(customerInfo);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
