import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:dynamic_color/dynamic_color.dart';

class DealCard extends StatelessWidget {
  const DealCard({super.key});

  @override
  Widget build(BuildContext context) {
    final advantages = ["Ad Free", "Nutritional Data", "Similar Recipes View"];
    final advantagesIcons = [
      Symbols.ad_off_rounded,
      Symbols.nutrition_rounded,
      Symbols.find_in_page_rounded,
    ];

    return Container(
      height: 330,
      width: 500,
      //padding: EdgeInsets.all(20),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade400
                .harmonizeWith(Color.fromARGB(255, 156, 134, 244)),
            Colors.green.shade800
                .harmonizeWith(Color.fromARGB(255, 226, 134, 244)),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        shadows: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(12, 12),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Clip Art
              //Align(
              //  alignment: Alignment.topRight,
              //  child: Image.asset(
              //    'assets/images/recipe_collection_clipart.png',
              //    height: 135,
              //    fit: BoxFit.fill,
              //  ),
              //),

              // Title And Price
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Limited Time Deal!',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 3.3,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Price
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$7.00',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' / 2 months',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Advantages List
          Expanded(
            child: Center(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Icon(advantagesIcons[index]),
                      SizedBox(width: 9),
                      Text(
                        advantages[index],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 9),
                itemCount: advantages.length,
              ),
            ),
          ),

          // Buy Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green
                      .harmonizeWith(Color.fromARGB(255, 261, 134, 244)),
                  minimumSize: Size(400, 50),
                ),
                child: Text(
                  'Get Deal',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
