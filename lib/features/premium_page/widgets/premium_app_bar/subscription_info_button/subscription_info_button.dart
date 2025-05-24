import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:recipe_box/shared/themes/colors.dart';

import 'package:recipe_box/features/premium_page/widgets/premium_app_bar/subscription_info_button/manage_and_restore_buttons.dart';
import 'package:recipe_box/features/premium_page/widgets/premium_app_bar/subscription_info_button/time_remaining_display.dart';

import 'package:material_symbols_icons/symbols.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SubscriptionInfoButton extends StatefulWidget {
  final CustomerInfo? customerInfo;
  final bool premiumActive;
  const SubscriptionInfoButton({
    required this.premiumActive,
    required this.customerInfo,
    super.key,
  });

  @override
  State<SubscriptionInfoButton> createState() => _SubscriptionInfoButtonState();
}

class _SubscriptionInfoButtonState extends State<SubscriptionInfoButton> {
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlayMenu() {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // Overlay Popup
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - 120,
        top: offset.dy + size.height + 10,
        child: WidgetAnimator(
          incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: PremiumColors.darkPurple.withGreen(100),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: BackdropFilter(
                  enabled: true,
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Column(
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 6),

                      // Time Left
                      if (widget.customerInfo != null &&
                          widget.premiumActive) ...[
                        TimeRemainingDisplay(
                          expirationDate: widget.customerInfo!.entitlements
                              .active['premium']!.expirationDate,
                        ),
                      ],

                      // Restore
                      RestorePurchaseButton(),

                      // Manage
                      if (widget.premiumActive) ...[
                        ManageSubscriptionButton(
                          manageUrl: widget.customerInfo!.managementURL!,
                        ),
                      ],

                      SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    OverlayState? overlayState = Overlay.of(context);
    overlayState.insert(_overlayEntry!);
    LocalHistoryEntry historyEntry = LocalHistoryEntry(
      onRemove: () {
        _overlayEntry?.remove();
        _overlayEntry = null;
      },
    );
    ModalRoute.of(context)?.addLocalHistoryEntry(historyEntry);
  } // _showOverlayMenu()

  @override
  Widget build(BuildContext context) {
    // Info Button
    return IconButton.filled(
      key: _buttonKey,
      onPressed: () {
        if (_overlayEntry?.mounted ?? false) {
          _removeOverlay();
        } else {
          _showOverlayMenu();
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          PremiumColors.darkPurple,
        ),
      ),
      icon: Icon(
        Symbols.view_agenda,
        size: 25,
        color: Colors.white,
        weight: 5000,
      ),
    );
  }
}
