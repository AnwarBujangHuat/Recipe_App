import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/apps/widgets/search_bar.dart';
import 'package:fort_asia_recipe_app/src/features/home/viewmodel/home_viewmodel.dart';
import 'package:fort_asia_recipe_app/src/features/home/widgets/recipe_card.dart';
import 'package:fort_asia_recipe_app/src/features/home/widgets/recipe_type_selection.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: Text(
          AppLocalizations.of(context)!.home,
        ),
      ),

      /// Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.addNewRecipePage);
        },
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
        child: Column(
          children: [
            SearchBarWidget(
              controller: searchController,
              onChanged: (query) => ref
                  .read(homeViewmodelProvider.notifier)
                  .filterBySearchKey(query: query),
            ),
            const RecipeTypesSelection(),
            ref.watch(homeViewmodelProvider).when(
                  data: (recipes) {
                    if (recipes.isEmpty) {
                      return Expanded(
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.emptyRecipe)),
                      );
                    }
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                childAspectRatio: .8),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) => RecipeCard(
                          recipeModel: recipes[index],
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ),
      )),
    );
  }
}
