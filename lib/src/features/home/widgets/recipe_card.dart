import 'package:flutter/material.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({required this.recipeModel, super.key});
  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, RouteName.detailsPage,arguments:  recipeModel.id),
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: AppSize.elevationLow,
          margin: const EdgeInsets.all(AppSize.paddingSmall),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  recipeModel.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: const EdgeInsets.all(AppSize.paddingSmall),
                      constraints: const BoxConstraints(
                          minWidth: double.maxFinite,
                          minHeight: AppSize.appSizeS80),
                      color: AppColors.black.withOpacity(.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipeModel.name,
                            style: const TextStyle(
                                fontSize: FontSize.mediumTitle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                          Text(recipeModel.description,
                              style: const TextStyle(
                                  fontSize: FontSize.body,
                                  color: AppColors.white)),
                          const SizedBox(
                            height: AppSize.appSizeS10,
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}
