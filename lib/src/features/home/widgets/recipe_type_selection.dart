import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/features/home/viewmodel/home_viewmodel.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_type_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fort_asia_recipe_app/src/viewModel/recipe_types_viewmodel.dart';

class RecipeTypesSelection extends ConsumerStatefulWidget {
  const RecipeTypesSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecipeTypesSelectionState();
}

class _RecipeTypesSelectionState extends ConsumerState<RecipeTypesSelection> {
  final Set<RecipeTypeModel> _selectedRecipeTypes = {};
  final Set<RecipeTypeModel> _recipeTypes = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(recipeTypeViewmodelProvider).when(
      data: (data) {
        setState(() {
          _recipeTypes.addAll(data);
          if (_selectedRecipeTypes.isEmpty) {
            _selectedRecipeTypes.addAll(_recipeTypes);
          }
        });
        return SizedBox(
          height: AppSize.appSizeS60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _recipeTypes.length,
            itemBuilder: (context, index) {
              bool isSelected =
                  _selectedRecipeTypes.contains(_recipeTypes.elementAt(index));

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2, vertical: AppSize.paddingSmall),
                child: OutlinedButton(
                  style: !isSelected
                      ? null
                      : const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color?>(
                              AppColors.redAlizarin)),
                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        if (_selectedRecipeTypes.length > 1) {
                          _selectedRecipeTypes
                              .remove(_recipeTypes.elementAt(index));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  AppLocalizations.of(context)!.errEmptyType),
                            ),
                          );
                        }
                      } else {
                        _selectedRecipeTypes.add(_recipeTypes.elementAt(index));
                      }
                      ref.read(homeViewmodelProvider.notifier).filterByType(
                          type: _selectedRecipeTypes.map((e) => e.id).toSet());
                    });
                  },
                  child: Text(
                    _recipeTypes.elementAt(index).name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.body,
                      color: isSelected ? Colors.white : AppColors.redAlizarin,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return Container();
      },
    );
  }
}
