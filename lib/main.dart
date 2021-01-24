import 'package:at_list/app/themes.dart';
import 'package:at_list/services/getIt.dart';
import 'package:at_list/services/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/router.gr.dart';
import 'ui/homeView/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(); // Creates all necessary services for get_it
  await Hive.initFlutter();
  await initializeServices();
  await ThemeManager.initialise();
  await atProtocolService.setupAtProtocol();
  runApp(Gateway());
}

/// Gateway into app. Will be used to route user to different screen based on
/// authentication status
class Gateway extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      defaultThemeMode: ThemeMode.light,
      builder: (context, regularTheme, darkTheme, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: regularTheme,
          darkTheme: darkTheme,
          builder: ExtendedNavigator.builder(
            router: AppRouter(),
            initialRoute: Routes.homeView,
            builder: (context, child) {
              return child;
            },
          ),
        );
      },
    );
  }
}
