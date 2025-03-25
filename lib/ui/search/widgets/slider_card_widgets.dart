import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class MaxReadyTimeSlider extends StatefulWidget {
  final double givenPrimarySliderValue;
  final String primaryTitle;
  final TextStyle titleTextStyle;
  final Function(Map<String, dynamic>) setValue;
  final bool Function() isModified;
  const MaxReadyTimeSlider({
    required this.givenPrimarySliderValue,
    required this.primaryTitle,
    required this.isModified,
    required this.titleTextStyle,
    required this.setValue,
    super.key,
  });
  @override
  State<MaxReadyTimeSlider> createState() => MaxReadyTimeState();
}

class MaxReadyTimeState extends State<MaxReadyTimeSlider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.primaryTitle, style: widget.titleTextStyle),
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                  outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
                  child: widget.isModified()
                      ? Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.edit_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : null,
                )
              ],
            ),
            Slider(
              value: widget.givenPrimarySliderValue,
              min: 30,
              max: 720,
              divisions: 360,
              label: minutesToHourMin(widget.givenPrimarySliderValue.round()),
              onChanged: (double value) {
                setState(() {
                  double remainder = value.round() % 30;
                  final newValue = value.round() - remainder;
                  widget.setValue({'maxTime': newValue});
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String minutesToHourMin(int value) {
    int hours, minutes, remainder;
    hours = value ~/ 60;
    remainder = value % 60;

    if (remainder >= 30) {
      minutes = 30;
    } else {
      minutes = 0;
    }

    String result = "${hours}h:${minutes}m";
    return result;
  }
}

class MinMaxSliders extends StatefulWidget {
  final String title;
  final bool Function() isModified;
  final RangeValues range;
  final double sliderMaximum;
  final double sliderMinimum;
  final Function(Map<String, dynamic>) updateState;
  final TextStyle titleTextStyle;
  const MinMaxSliders({
    required this.title,
    required this.range,
    required this.sliderMaximum,
    required this.sliderMinimum,
    required this.isModified,
    required this.updateState,
    required this.titleTextStyle,
    super.key,
  });
  @override
  State<MinMaxSliders> createState() => _MinMaxSlidersState();
}

class _MinMaxSlidersState extends State<MinMaxSliders> {
  @override
  Widget build(BuildContext context) {
    TextStyle secondaryTitleStyle = const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );

    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title, style: widget.titleTextStyle),
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
                  outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
                  child: widget.isModified()
                      ? Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.edit_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : null,
                )
              ],
            ),
            const Divider(),
            SliderTheme(
              data: SliderThemeData(
                valueIndicatorColor: Theme.of(context).colorScheme.primary,
                rangeValueIndicatorShape:
                    PaddleRangeSliderValueIndicatorShape(),
              ),
              child: RangeSlider(
                values: widget.range,
                onChanged: (RangeValues newValue) {
                  widget.updateState({widget.title: newValue});
                },
                min: widget.sliderMinimum,
                max: widget.sliderMaximum,
                divisions: 100,
                labels: RangeLabels(
                  widget.range.start.round().toString(),
                  widget.range.end.round().toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
