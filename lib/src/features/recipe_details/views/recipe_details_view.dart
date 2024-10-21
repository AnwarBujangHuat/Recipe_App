import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/features/add_new_recipe/views/add_new_recipe_view.dart';
import 'package:fort_asia_recipe_app/src/features/home/viewmodel/home_viewmodel.dart';
import 'package:fort_asia_recipe_app/src/features/recipe_details/viewmodel/recipe_details_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';
import 'package:fort_asia_recipe_app/src/repositories/recipe_repository.dart';

class RecipeDetailsView extends ConsumerWidget {
  const RecipeDetailsView({required this.recipeId, super.key});
  final int recipeId;
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

  DecorationImage _getDecorationImage(String? imageUrl) {
    if (imageUrl == null) {
      return const DecorationImage(
        image: AssetImage(
            'assets/images/placeholder.png'), // Use a placeholder image
        fit: BoxFit.cover, // Adjust fit as needed
      );
    }
    // Check if the URL is valid
    if (imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasScheme == true) {
      return DecorationImage(
        image: NetworkImage(imageUrl), // Use network image
        fit: BoxFit.cover, // Adjust fit as needed
      );
    } else {
      // Attempt to use local file path if URL is not valid
      final localImage =
          File(imageUrl); // Assuming the URL can also be a local path
      if (localImage.existsSync()) {
        return DecorationImage(
          image: FileImage(localImage), // Use local file image
          fit: BoxFit.cover, // Adjust fit as needed
        );
      } else {
        // Fallback to a blank image
        return const DecorationImage(
          image: AssetImage(
              'assets/images/placeholder.png'), // Use a placeholder image
          fit: BoxFit.cover, // Adjust fit as needed
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(recipeDetailsViewmodelProvider(recipeID: recipeId)).when(
          data: (data) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            image: _getDecorationImage(data.thumbnail),
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
                        Positioned(
                            top: AppSize.appSizeS32,
                            right: AppSize.appSizeS20,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      // Navigate to the AddNewRecipeView to edit the recipe
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddNewRecipeView(
                                              recipeModel:
                                                  data), // Pass the recipe model
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.redAlizarin,
                                    ),
                                  ),
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      // Call the delete method from the view model
                                      ref
                                          .read(recipeRepositoryProvider)
                                          .deleteRecipe(data.id)
                                          .whenComplete(() {
                                        ref.refresh(homeViewmodelProvider);
                                        Navigator.pop(context);
                                      }); // Implement this method in your view model
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: AppColors.redAlizarin),
                                  ),
                                ],
                              ),
                            )),
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
                          if (data.steps.isEmpty)
                            Text(
                              AppLocalizations.of(context)!.noIngredient,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.redAlizarin),
                            ),
                          const SizedBox(height: 20),

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
                          if (data.steps.isEmpty)
                            Text(
                              AppLocalizations.of(context)!.noSteps,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.redAlizarin),
                            ),
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
        );
  }
}
