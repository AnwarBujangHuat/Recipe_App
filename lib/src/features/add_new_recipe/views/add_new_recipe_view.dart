import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/features/add_new_recipe/viewmodel/add_new_recipe_viewmodel.dart';
import 'package:fort_asia_recipe_app/src/features/home/viewmodel/home_viewmodel.dart';
import 'package:fort_asia_recipe_app/src/features/recipe_details/viewmodel/recipe_details_viewmodel.dart';
import 'package:fort_asia_recipe_app/src/model/recipe_model.dart';
import 'package:fort_asia_recipe_app/src/repositories/recipe_repository.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRecipeView extends ConsumerStatefulWidget {
  const AddNewRecipeView({required this.recipeModel, super.key});
  final RecipeModel? recipeModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewRecipeViewState();
}

class _AddNewRecipeViewState extends ConsumerState<AddNewRecipeView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.recipeModel?.name ?? '';
    _descriptionController.text = widget.recipeModel?.description ?? '';
  }

  Widget buildIngredient(IngredientModel ingredient, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall),
      child: Row(
        children: [
          const Icon(Icons.circle,
              size: AppSize.iconSizeSmall, color: AppColors.redAlizarin),
          const SizedBox(width: AppSize.paddingMedium),
          Text(
            '${ingredient.quantity} ${ingredient.name}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: AppColors.redAlizarin,
            ),
            onPressed: () {
              ref
                  .read(
                      addNewRecipeViewmodelProvider(recipe: widget.recipeModel)
                          .notifier)
                  .removeIngredient(index);
            },
          ),
        ],
      ),
    );
  }

  Widget buildStep(String step, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingSmall),
      child: Row(
        children: [
          const Icon(Icons.circle,
              size: AppSize.iconSizeSmall, color: AppColors.redAlizarin),
          const SizedBox(width: AppSize.paddingMedium),
          Expanded(
            child: Text(
              step,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: AppColors.redAlizarin,
            ),
            onPressed: () {
              ref
                  .read(
                      addNewRecipeViewmodelProvider(recipe: widget.recipeModel)
                          .notifier)
                  .removeStep(index);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showAddDialog(BuildContext context, String type) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController quantityController =
        TextEditingController(text: '1');

    int quantity = int.parse(quantityController.text);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.add),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == 'ingredient') ...[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterIngredient,
                  ),
                ),
                const SizedBox(
                  height: AppSize.paddingMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.quantity),
                    IconButton(
                      icon: const Icon(Icons.remove,
                          color: AppColors.redAlizarin),
                      onPressed: () {
                        if (quantity > 1) {
                          quantity--;
                          quantityController.text = quantity.toString();
                        }
                      },
                    ),
                    SizedBox(
                      width: AppSize.appSizeS48,
                      child: TextField(
                        controller: quantityController,
                        textAlign: TextAlign.center,
                        readOnly: true,
                        decoration: const InputDecoration(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: AppColors.redAlizarin),
                      onPressed: () {
                        quantity++;
                        quantityController.text = quantity.toString();
                      },
                    ),
                  ],
                ),
              ],
              if (type == 'step') ...[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterStep,
                  ),
                ),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.add),
              onPressed: () {
                if (type == 'ingredient') {
                  final ingredient = IngredientModel(
                    name: nameController.text,
                    quantity: quantityController.text,
                  );
                  ref
                      .read(addNewRecipeViewmodelProvider(
                              recipe: widget.recipeModel)
                          .notifier)
                      .addNewIngredient(ingredient: ingredient);
                } else if (type == 'step') {
                  ref
                      .read(addNewRecipeViewmodelProvider(
                              recipe: widget.recipeModel)
                          .notifier)
                      .addNewStep(step: nameController.text);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref
          .read(addNewRecipeViewmodelProvider(recipe: widget.recipeModel)
              .notifier)
          .editThumbnail(pickedFile.path);
    }
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
  Widget build(BuildContext context) {
    RecipeModel? currentRecipe =
        ref.watch(addNewRecipeViewmodelProvider(recipe: widget.recipeModel));
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: AppSize.appSizeS300,
                  decoration: BoxDecoration(
                    image: _getDecorationImage(currentRecipe?.thumbnail),
                    color: AppColors.whiteSnow,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(AppSize.borderRadiusLarge),
                    ),
                  ),
                  child: IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera_alt),
                    color: AppColors.redAlizarin,
                    iconSize: AppSize.iconSizeExtraLarge,
                  ),
                ),
                Positioned(
                  top: AppSize.appSizeS32,
                  left: AppSize.appSizeS20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSize.appSizeS32,
                  right: AppSize.appSizeS20,
                  child: TextButton(
                    onPressed: () async {
                      if (currentRecipe != null) {
                        currentRecipe = RecipeModel(
                            id: currentRecipe!.id,
                            name: _titleController.text,
                            recipeTypeId: currentRecipe!.recipeTypeId,
                            description: _descriptionController.text,
                            thumbnail: currentRecipe!.thumbnail,
                            ingredients: currentRecipe!.ingredients,
                            steps: currentRecipe!.steps);
                        if (widget.recipeModel == null) {
                          ref
                              .read(recipeRepositoryProvider)
                              .insertRecipe(currentRecipe!)
                              .whenComplete(() async {
                            final _ =
                                await ref.refresh(homeViewmodelProvider.future);
                            Navigator.pop(context);
                          });
                        } else {
                          ref
                              .read(recipeRepositoryProvider)
                              .updateRecipe(currentRecipe!)
                              .whenComplete(() async {
                            final _ =
                                await ref.refresh(homeViewmodelProvider.future);
                            ref.refresh(recipeDetailsViewmodelProvider(
                                recipeID: widget.recipeModel!.id));
                            Navigator.pop(context);
                          });
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.errEmptyRecipe),
                          ),
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: const TextStyle(
                        color: AppColors.redAlizarin,
                        fontSize: AppSize.appSizeS20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSize.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.redAlizarin,
                                  width: AppSize.appSizeS1)),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSize.paddingMedium),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.redAlizarin)),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.paddingLarge),
                  Text(
                    AppLocalizations.of(context)!.ingredients,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSize.paddingSmall),
                  if (currentRecipe?.ingredients != null)
                    for (var i = 0; i < currentRecipe!.ingredients.length; i++)
                      buildIngredient(currentRecipe!.ingredients[i], i),
                  TextButton.icon(
                    onPressed: () => showAddDialog(context, 'ingredient'),
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.redAlizarin,
                    ),
                    label: Text(AppLocalizations.of(context)!.addIngredient),
                  ),
                  const SizedBox(height: AppSize.paddingLarge),
                  Text(
                    AppLocalizations.of(context)!.directions,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSize.paddingSmall),
                  if (currentRecipe?.steps != null)
                    for (var i = 0; i < currentRecipe!.steps.length; i++)
                      buildStep(currentRecipe!.steps[i], i),
                  TextButton.icon(
                    onPressed: () => showAddDialog(context, 'step'),
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.redAlizarin,
                    ),
                    label: Text(AppLocalizations.of(context)!.addStep),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
