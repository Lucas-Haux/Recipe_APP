import 'package:flutter/material.dart';

import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class ClearFiltersIndicator extends StatelessWidget {
  final bool isModified;
  const ClearFiltersIndicator({required this.isModified, super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
      outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToLeft(),
      child: isModified
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
              child: Container(
                height: 20,
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      strokeAlign: 2,
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_rounded, size: 15),
                    Text(
                      'Modified',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
