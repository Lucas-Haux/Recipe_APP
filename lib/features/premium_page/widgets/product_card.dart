import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final advantages = ["Ad Free", "Nutritional Data", "Similar Recipes View"];
final advantagesIcons = [
  Symbols.ad_off_rounded,
  Symbols.nutrition_rounded,
  Symbols.find_in_page_rounded,
];

final defaultColors = [
  Color.fromARGB(255, 156, 134, 244),
  Color.fromARGB(255, 226, 134, 244),
];
final limitedTimeColors = [
  Colors.green.shade400.harmonizeWith(Color.fromARGB(255, 156, 134, 244)),
  Colors.green.shade800.harmonizeWith(Color.fromARGB(255, 226, 134, 244)),
];

class ProductCard extends StatelessWidget {
  final Package product;
  final bool clipArt;
  final Map<String, Object> metaData;
  const ProductCard({
    required this.product,
    required this.clipArt,
    required this.metaData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool limitedTime = metaData["limitedTime"] as bool;

    //print("${metaData["id"]} & $limitedTime");

    final Gradient cardGradient = LinearGradient(
      colors: limitedTime ? limitedTimeColors : defaultColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      height: 360,
      width: 500,
      decoration: ShapeDecoration(
        gradient: cardGradient,
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
          SizedBox(
            height: 135,
            child: Stack(
              children: [
                // Clip Art
                if (clipArt == true)
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/recipe_collection_clipart.png',
                      height: 135,
                      fit: BoxFit.fill,
                    ),
                  ),

                // Title And Price
                Padding(
                  padding: EdgeInsets.only(top: 35, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        limitedTime ? 'Limited Time Deal' : 'PREMIUM',
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
                              text: product.storeProduct.priceString,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' / ${metaData["subscriptionLength"]}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
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
          ),

          //SizedBox(height: 5),

          // Advantages List
          Expanded(
            child: Center(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
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
                    const SizedBox(height: 12),
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
                onPressed: () async {
                  await Purchases.purchasePackage(product);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  //foregroundColor: Color.fromARGB(255, 261, 134, 244),
                  minimumSize: Size(400, 50),
                ),
                child: Text(
                  'Get Premium',
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
