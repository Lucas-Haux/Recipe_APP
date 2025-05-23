import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:recipe_box/features/recipe_display_page/widgets/similar_recipes_card_manager.dart';
import 'package:recipe_box/shared/models/recipe.dart';
import 'package:recipe_box/shared/ui/basic_recipe_display_card.dart';

class SimilarRecipesCard extends ConsumerWidget {
  final Recipe recipe;
  final dynamic database;
  final double cardWidth;

  const SimilarRecipesCard({
    required this.recipe,
    required this.database,
    required this.cardWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager =
        ref.watch(similarRecipesCardManagerProvider(database, recipe));

    final double height = MediaQuery.sizeOf(context).height;

    return Column(
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      children: [
        //Title
        TextAnimator(
          'Similar Recipes',
          atRestEffect: WidgetRestingEffects.wave(
            duration: Duration(milliseconds: 2500),
          ),
          textAlign: TextAlign.center,
          initialDelay: const Duration(milliseconds: 50),
          spaceDelay: const Duration(milliseconds: 65),
          characterDelay: const Duration(milliseconds: 65),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            shadows: [
              Shadow(
                  blurRadius: 9,
                  color: Colors.white.withAlpha(70),
                  offset: Offset(-3, -3)),
              Shadow(
                  blurRadius: 9,
                  color: Colors.white.withAlpha(70),
                  offset: Offset(3, -3)),
              Shadow(
                  blurRadius: 9,
                  color: Colors.white.withAlpha(70),
                  offset: Offset(-3, 3)),
              Shadow(
                  blurRadius: 9,
                  color: Colors.white.withAlpha(70),
                  offset: Offset(3, 3)),
            ],
          ),
        ),

        // Content
        manager.when(
          data: (similarRecipes) {
            similarRecipes = ref
                .watch(similarRecipesCardManagerProvider(database, recipe))
                .value;
            if (similarRecipes == null || similarRecipes.isEmpty) {
              return DottedBorder(
                padding:
                    const EdgeInsets.symmetric(vertical: 75, horizontal: 80),
                dashPattern: const [6, 10],
                color: Theme.of(context).colorScheme.outlineVariant,
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
                child: OutlinedButton(
                  onPressed: () async {
                    ref
                        .watch(
                            similarRecipesCardManagerProvider(database, recipe)
                                .notifier)
                        .searchForSimilarRecipes();
                  },
                  child: const Text('Find Similar Recipes'),
                ),
              );
            } else {
              return _Carousel(
                similarRecipes: similarRecipes,
                height: height,
                cardWidth: cardWidth,
              );
            }
          },
          error: (error, stackTrace) => Text('Error: $error \n $stackTrace'),
          loading: () => _Carousel(
            height: height,
            cardWidth: cardWidth,
          ),
        ),
      ],
    );
  }
}

class _Carousel extends StatelessWidget {
  final List<SimilarRecipe>? similarRecipes;
  final double height;
  final double cardWidth;
  const _Carousel({
    this.similarRecipes,
    required this.height,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      constraints: BoxConstraints(maxHeight: height / 4.0),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 30,
            spreadRadius: 00,
            color: Colors.black45,
            //color: Colors.green,
            inset: true,
          ),
        ],
      ),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: [0.0, 0.1, 0.90, 1],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: CarouselView.weighted(
          controller: CarouselController(
            initialItem:
                (similarRecipes != null) ? similarRecipes!.length ~/ 2 : 1,
          ),
          shrinkExtent: 500,
          onTap: (int index) {
            if (similarRecipes != null) {
              final route = ModalRoute.of(context)!.settings.name!;
              final similarRecipe = similarRecipes![index];
              final Map<String, dynamic> arguments = {
                'recipeTitle': similarRecipe.title,
                'id': similarRecipe.recipeId,
                'recipeImageUrl': similarRecipe.imageUrl
              };
              Navigator.pushNamed(
                context,
                '$route/temp',
                arguments: arguments,
              );
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          padding: EdgeInsets.all(9),
          itemSnapping: true,
          flexWeights: const <int>[2, 3, 2],
          children: (similarRecipes != null)
              ? similarRecipes!.map((SimilarRecipe recipe) {
                  return BasicRecipeDisplayCard(
                    expand: true,
                    imageUrl: recipe.imageUrl!,
                    title: recipe.title!,
                    id: recipe.recipeId!,
                    cardWidth: cardWidth,
                  );
                }).toList()
              : List.generate(
                  5,
                  (index) => _ShimmeringRecipeCard(cardWidth: cardWidth),
                ),
        ),
      ),
    );
  }
}

class _ShimmeringRecipeCard extends StatelessWidget {
  final double cardWidth;

  const _ShimmeringRecipeCard({required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.onSecondary,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade600,
          highlightColor: Colors.grey.shade300,
          child: Column(
            children: [
              Container(
                width: cardWidth,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 9,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 9,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 50),
                child: Container(
                  height: 9,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
