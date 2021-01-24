// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:atsign_authentication_helper/screens/scan_qr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/homeView/home_view.dart';
import '../ui/signInview/sign_in_view.dart';

class Routes {
  static const String homeView = '/';
  static const String signInView = '/sign-in-view';
  static const String scanQrScreen = '/scan-qr-screen';
  static const all = <String>{
    homeView,
    signInView,
    scanQrScreen,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(Routes.scanQrScreen, page: ScanQrScreen),
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
    ScanQrScreen: (data) {
      final args = data.getArgs<ScanQrScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ScanQrScreen(
          key: args.key,
          nextScreen: args.nextScreen,
          atClientServiceInstance: args.atClientServiceInstance,
          atClientPreference: args.atClientPreference,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ScanQrScreen arguments holder class
class ScanQrScreenArguments {
  final Key key;
  final Widget nextScreen;
  final AtClientService atClientServiceInstance;
  final AtClientPreference atClientPreference;
  ScanQrScreenArguments(
      {this.key,
      @required this.nextScreen,
      @required this.atClientServiceInstance,
      @required this.atClientPreference});
}
