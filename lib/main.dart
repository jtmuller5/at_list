import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_list/app/themes.dart';
import 'package:at_list/services/getIt.dart';
import 'package:at_list/services/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/router.gr.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(); // Creates all necessary services for get_it
  await Hive.initFlutter(); // Initialize Hive DB for future use
  await initializeServices(); // Perform service specific setup (open Hive boxeS)
  await ThemeManager.initialise(); // Setup for using stacked_themes
  await atProtocolService.setup(); // Get any @signs from the keychain manager
  runApp(Gateway());
}

/// Gateway into app. Will be used to route user to different screen based on
/// the status of the current AtClient
class Gateway extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: atProtocolService.onboard(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return App(
                initialRoute: Routes.homeView,
              );
            } else {
              return App(initialRoute: Routes.signInView);
            }
          }

          else if(snapshot.hasError){
            return App(initialRoute: Routes.signInView);
          }

          else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class App extends StatelessWidget {
  final String initialRoute;

  const App({Key key, @required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      defaultThemeMode: ThemeMode.light,
      builder: (context, regularTheme, darkTheme, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: regularTheme,
          darkTheme: darkTheme,
          builder: ExtendedNavigator.builder(
            router: AppRouter(),
            navigatorKey: atProtocolService.navKey,
            initialRoute: initialRoute,
            builder: (context, child) {
              return child;
            },
          ),
        );
      },
    );
  }
}
