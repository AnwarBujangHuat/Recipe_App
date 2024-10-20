import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fort_asia_recipe_app/src/apps/constants.dart';
import 'package:fort_asia_recipe_app/src/features/home/views/home_view.dart';
import 'package:fort_asia_recipe_app/src/features/recipe_details/views/recipe_details_view.dart';

import '../features/settings/settings_controller.dart';
import '../features/settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData().copyWith(
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: AppColors.redAlizarin,
                  onPrimary: AppColors.white,
                  secondary: AppColors.whiteSmoke,
                  onSecondary: AppColors.white,
                  error: AppColors.redAlizarin,
                  onError: AppColors.white,
                  surface: Colors.white,
                  onSurface: AppColors.whiteSmoke),

              /// Scaffold Background color
              scaffoldBackgroundColor: AppColors.white,
              cardColor: Colors.white60,

              ///Alert Dialog Design
              dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppSize.appSizeS10))),
                  backgroundColor: AppColors.white,
                  surfaceTintColor: AppColors.white,
                  titleTextStyle: TextStyle(
                      fontSize: FontSize.smallTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.redAlizarin)),

              /// App Bar Theme
              appBarTheme: const AppBarTheme(
                  surfaceTintColor: Colors.transparent,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: AppColors.redAlizarin),
                  titleTextStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.redAlizarin,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.largeTitle)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSize.appSizeS10,
                    ),
                  ),
                ),
                minimumSize: const WidgetStatePropertyAll(
                    Size(AppSize.appSizeS0, AppSize.appSizeS48)),
                textStyle: const WidgetStatePropertyAll(
                  TextStyle(overflow: TextOverflow.ellipsis),
                ),
              )),

              /// Button Theme
              outlinedButtonTheme: OutlinedButtonThemeData(
                  style: ButtonStyle(
                      minimumSize: const WidgetStatePropertyAll(
                          Size(AppSize.appSizeS0, AppSize.appSizeS48)),
                      textStyle: const WidgetStatePropertyAll(
                        TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.redAlizarin),
                          borderRadius: BorderRadius.circular(
                            AppSize.appSizeS10,
                          ),
                        ),
                      ))),

              /// Input Decoration
              inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: AppColors.whiteSmoke,
                  contentPadding: const EdgeInsets.all(AppSize.paddingMedium),
                  labelStyle: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    letterSpacing: AppSize.appSizeS0,
                    fontSize: FontSize.smallTitle,
                    color: AppColors.white,
                  ),
                  iconColor: AppColors.redAlizarin,
                  prefixIconColor: AppColors.redAlizarin,
                  suffixIconColor: AppColors.redAlizarin,
                  hintStyle: const TextStyle(
                    letterSpacing: AppSize.appSizeS0,
                    fontSize: FontSize.smallTitle,
                    color: AppColors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.whiteSmoke),
                      borderRadius: BorderRadius.circular(AppSize.appSizeS10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.whiteSmoke),
                      borderRadius: BorderRadius.circular(AppSize.appSizeS10))),
              buttonTheme: const ButtonThemeData(height: AppSize.appSizeS48)),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case RouteName.settingPage:
                    return SettingsView(controller: settingsController);
                  case RouteName.homePage:
                    return const HomeView();
                  case RouteName.detailsPage:
                    return RecipeDetailsView(
                      recipeId: routeSettings.arguments as int,
                    );

                  /// Default first
                  default:
                    return const HomeView();
                }
              },
            );
          },
        );
      },
    );
  }
}
