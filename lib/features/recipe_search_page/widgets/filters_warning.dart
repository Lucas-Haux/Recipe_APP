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
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
                  color: Colors.black87,
                  size: 40,
                ),
                Text(
                  'Warning:',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                )
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _warningText(),
            ),
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
          fontWeight: FontWeight.w400,
        ),
        children: [
          if (expanded == true) ...[
            TextSpan(
              text: 'Not all recipes are perfectly tagged. Filters like ',
            ),
            TextSpan(
              text: 'Meal Type, Cuisines, Diets, and Intolerances ',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: 'might be missing from some recipes. This means that ',
            ),
          ],
          TextSpan(
            text:
                'Some recipes that *should* match your filters may not appear in the results. \n',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          if (expanded == true)
            TextSpan(
              text:
                  "\n Tip: If you're not finding what you're looking for, try removing a filter or two! You might discover a hidden gem. 😉 \n",
              //style: TextStyle(decoration: TextDecoration.underline),
            ),
        ],
      ),
    );
  }
}
