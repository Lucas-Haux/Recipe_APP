import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

    Widget buildMenuItem(Widget widget) {
      return InkWell(
        onTap: () {
          _removeOverlay();
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: widget,
        ),
      );
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - 110,
        top: offset.dy + size.height + 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 156, 134, 244).withAlpha(200),
                  Color.fromARGB(255, 226, 134, 244).withAlpha(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Time Left
                    if (widget.customerInfo != null && widget.premiumActive)
                      buildMenuItem(_TimeLeftDisplay(
                          expirationDate: widget
                              .customerInfo!.allExpirationDates.values.first)),

                    // Restore
                    buildMenuItem(RestorePurchaseButton()),

                    // Manage
                    if (widget.premiumActive)
                      buildMenuItem(
                        ManageSubscriptionButton(
                            manageUrl: widget.customerInfo!.managementURL!),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    OverlayState? overlayState = Overlay.of(context);

    if (overlayState != null) {
      // Insert the overlay
      overlayState.insert(_overlayEntry!);

      // Create a LocalHistoryEntry to tie the overlay to the route
      LocalHistoryEntry historyEntry = LocalHistoryEntry(
        onRemove: () {
          // This is called when the route is popped or replaced
          _overlayEntry?.remove(); // Remove the overlay
          _overlayEntry = null; // Set to null to avoid trying to remove again
        },
      );

      // Add the LocalHistoryEntry to the current route's history
      ModalRoute.of(context)?.addLocalHistoryEntry(historyEntry);
    }

    //Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
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
          Color.fromARGB(255, 156, 134, 244),
        ),
      ),
      child: Icon(
        Symbols.view_agenda,
        size: 25,
        color: Colors.white,
        weight: 5000,
      ),
    );
  }
}

class _TimeLeftDisplay extends StatelessWidget {
  final String? expirationDate;
  const _TimeLeftDisplay({required this.expirationDate});

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    final dateExpiration = DateTime.parse(expirationDate ?? '');

    final difference = dateExpiration.difference(dateNow);
    int days = difference.inDays;
    int hours = difference.inHours % 24; // Remaining hours after full days
    int minutes =
        difference.inMinutes % 60; // Remaining minutes after full hours
    int seconds = difference.inSeconds % 60; // Remaining seconds a
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 156, 134, 244),
        ),
        child: !(difference.isNegative)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time Remaining:',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  // Remove minutes and add days
                  Text('Hours: $hours Minutes: $minutes'),
                ],
              )
            : Text('Time Remaining: 0'));
  }
}

class RestorePurchaseButton extends StatelessWidget {
  const RestorePurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      // TODO show when restore was successful or not
      onPressed: () => Purchases.restorePurchases(),
      style: FilledButton.styleFrom(
          padding: EdgeInsets.all(5),
          backgroundColor: Color.fromARGB(255, 226, 134, 244),
          foregroundColor: Colors.white),
      child: Row(children: [
        Spacer(),
        Icon(Symbols.cloud_sync_rounded, color: Colors.white),
        SizedBox(width: 5),
        Text('Restore Purchase', style: TextStyle(fontSize: 13)),
        Spacer(),
      ]),
    );
  }
}

class ManageSubscriptionButton extends StatelessWidget {
  final String manageUrl;
  const ManageSubscriptionButton({required this.manageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        final Uri url = Uri.parse(manageUrl);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      style: FilledButton.styleFrom(
          padding: EdgeInsets.all(5),
          backgroundColor: Color.fromARGB(255, 156, 134, 244),
          foregroundColor: Colors.white),
      child: Row(children: [
        Spacer(),
        Icon(Symbols.manage_accounts_rounded, color: Colors.white),
        SizedBox(width: 5),
        Text('Manage Subscription', style: TextStyle(fontSize: 13)),
        Spacer(),
      ]),
    );
  }
}
