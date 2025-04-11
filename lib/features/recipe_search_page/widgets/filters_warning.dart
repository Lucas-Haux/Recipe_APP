import 'package:flutter/material.dart';

class FiltersWarning extends StatefulWidget {
  const FiltersWarning({super.key});

  @override
  State<FiltersWarning> createState() => _FiltersWarningState();
}

class _FiltersWarningState extends State<FiltersWarning> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        expanded = !expanded;
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        margin: EdgeInsets.symmetric(horizontal: 7),
        decoration: ShapeDecoration(
          gradient: LinearGradient(colors: [
            Colors.orange,
            Colors.deepOrange,
          ]),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.black,
                  size: 40,
                ),
                Text(
                  'Warning:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                )
              ],
            ),
            _warningText(),
          ],
        ),
      ),
    );
  }

  Widget _warningText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
            fontSize: 18,
            color: Colors.black.withAlpha(200),
            fontWeight: FontWeight.w400),
        children: [
          if (expanded == true) ...[
            TextSpan(
              text: 'Not All Recipes Are Accurately Labled, Filters Like ',
            ),
            TextSpan(
              text: 'Meal Type, Cuisines, Diets, and Intolerances ',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: 'Are Often Missing From Many Recipes. Meaning That ',
            ),
          ],
          TextSpan(
            text:
                'Some Of The Recipes That Should Fit With Your Filters Wont Be Returned. \n',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          if (expanded == true)
            TextSpan(
              text:
                  "\n So If You're Not Getting The Recipe You're Looking For It's Recommened To Remove Some Of Your Filters Because Of This Limitation :/ \n",

              //style: TextStyle(decoration: TextDecoration.underline),
            ),
        ],
      ),
    );
  }
}
