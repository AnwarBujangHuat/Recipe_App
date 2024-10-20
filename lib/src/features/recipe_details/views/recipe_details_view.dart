import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/features/recipe_details/viewmodel/recipe_details_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';

class RecipeDetailsView extends ConsumerWidget {
  const RecipeDetailsView({required this.recipeId, super.key});
  final int recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildIngredient(IngredientModel ingredient) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(Icons.circle, size: 8, color: Colors.red[700]),
            const SizedBox(width: 10),
            Text(
              '${ingredient.quantity} ${ingredient.name}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget buildStep(String step) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 8, color: AppColors.redAlizarin),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                step,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ref.watch(recipeDetailsViewmodelProvider(recipeID: recipeId)).when(
            data: (data) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: AppSize.appSizeS300,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom:
                                    Radius.circular(AppSize.borderRadiusLarge),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  data.thumbnail,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: AppSize.appSizeS32,
                            left: AppSize.appSizeS20,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Recipe Details
                      Padding(
                        padding: const EdgeInsets.all(AppSize.paddingLarge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Rating
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data.description,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Ingredients Section
                            Text(
                              AppLocalizations.of(context)!.ingredients,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            for (var ingredients in data.ingredients)
                              buildIngredient(ingredients),

                            SizedBox(height: 20),

                            // Directions Section
                            Text(
                              AppLocalizations.of(context)!.directions,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            for (var step in data.steps) buildStep(step),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
