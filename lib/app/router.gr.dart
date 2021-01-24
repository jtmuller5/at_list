// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../ui/homeView/home_view.dart';
import '../ui/signInview/sign_in_view.dart';

class Routes {
  static const String homeView = '/';
  static const String signInView = '/sign-in-view';
  static const all = <String>{
    homeView,
    signInView,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.signInView, page: SignInView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    SignInView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SignInView(),
        settings: data,
      );
    },
  };
}
