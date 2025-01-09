import 'package:flutter/material.dart';

class MaxReadyTimeSlider extends StatefulWidget {
  final double givenPrimarySliderValue;
  final String primaryTitle;
  final TextStyle titleTextStyle;
  final void Function(double) setValue;
  const MaxReadyTimeSlider({
    required this.givenPrimarySliderValue,
    required this.primaryTitle,
    required this.titleTextStyle,
    required this.setValue,
    super.key,
  });
  @override
  State<MaxReadyTimeSlider> createState() => MaxReadyTimeState();
}

class MaxReadyTimeState extends State<MaxReadyTimeSlider> {
  late double _primarySliderValue;

  @override
  void initState() {
    super.initState();
    _primarySliderValue = widget.givenPrimarySliderValue; // Initialize state
  }

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
      child: Column(
        children: <Widget>[
          Text(widget.primaryTitle, style: widget.titleTextStyle),
          Slider(
            value: _primarySliderValue,
            min: 30,
            max: 720,
            divisions: 360,
            label: minutesToHourMin(_primarySliderValue.round()),
            onChanged: (double value) {
              setState(() {
                double remainder = value.round() % 30;
                _primarySliderValue = value.round() - remainder;
                widget.setValue(_primarySliderValue);
              });
            },
          ),
        ],
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
  final double givenMaxValue;
  final double givenMinValue;
  final double sliderMaximum;
  final double sliderMinimum;
  final void Function(double) setMaxValue;
  final void Function(double) setMinValue;
  final TextStyle titleTextStyle;
  const MinMaxSliders({
    required this.title,
    required this.givenMaxValue,
    required this.givenMinValue,
    required this.sliderMaximum,
    required this.sliderMinimum,
    required this.setMaxValue,
    required this.setMinValue,
    required this.titleTextStyle,
    super.key,
  });
  @override
  State<MinMaxSliders> createState() => _MinMaxSlidersState();
}

class _MinMaxSlidersState extends State<MinMaxSliders> {
  late double _maxSliderValue;
  late double _minSliderValue;

  @override
  void initState() {
    super.initState();
    _maxSliderValue = widget.givenMaxValue; // Initialize state
    _minSliderValue = widget.givenMinValue;
  }

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
      child: Column(
        children: <Widget>[
          Text(widget.title, style: widget.titleTextStyle),
          const Divider(),

          // Min
          Text('Minimum', style: secondaryTitleStyle),
          Slider(
            value: _minSliderValue,
            min: widget.sliderMinimum,
            max: widget.sliderMaximum,
            divisions: 100,
            secondaryTrackValue: _maxSliderValue,
            label: _minSliderValue.round().toString(),
            onChanged: (double newValue) {
              setState(() {
                widget.setMaxValue(newValue);
                _minSliderValue = newValue.round().toDouble();
              });
            },
          ),

          // Max
          Text('Maximum', style: secondaryTitleStyle),
          Slider(
            value: _maxSliderValue,
            min: widget.sliderMinimum,
            max: widget.sliderMaximum,
            divisions: 100,
            secondaryTrackValue: _minSliderValue,
            label: _maxSliderValue.round().toString(),
            onChanged: (double newValue) {
              setState(() {
                _maxSliderValue = newValue.round().toDouble();
                widget.setMaxValue(newValue);
              });
            },
          ),
        ],
      ),
    );
  }
}
