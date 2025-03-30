import 'package:flutter/material.dart';

class SettingsAndTokensButtons extends StatelessWidget {
  const SettingsAndTokensButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Settings Buttons
        _Button(
          label: 'Settings',
          icon: Icons.settings_rounded,
          gradientColorOne: Colors.grey,
          gradientColorTwo: Colors.blueGrey,
          onTap: () {},
        ),

        const Spacer(),

        // Tokens Button
        _Button(
          label: 'Tokens',
          icon: Icons.generating_tokens_rounded,
          gradientColorOne: Colors.yellow,
          gradientColorTwo: Colors.orange,
          onTap: () {},
        )
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Color gradientColorOne;
  final Color gradientColorTwo;
  final IconData icon;
  final String label;
  final Function() onTap;

  const _Button({
    required this.gradientColorOne,
    required this.gradientColorTwo,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double buttonHeight = 40;
    double topPadding = 10;
    double bottomPadding = 5;

    return GestureDetector(
      onTap: onTap(),
      // Buttons Shape
      child: Container(
        //constraints: BoxConstraints(maxHeight: height / 4.5),
        constraints: BoxConstraints(maxHeight: buttonHeight),
        padding: EdgeInsets.symmetric(
          horizontal: topPadding,
          vertical: bottomPadding,
        ),
        //margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          gradient: LinearGradient(
            colors: [gradientColorOne, gradientColorTwo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shadows: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(2, 4),
            ),
          ],
        ),
        // Button Contents
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 7),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
