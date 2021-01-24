import 'package:at_list/ui/homeView/home_view.dart';
import 'package:at_list/ui/signInview/sign_in_view.dart';
import 'package:atsign_authentication_helper/screens/scan_qr.dart';
import 'package:auto_route/auto_route_annotations.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute> [
    AutoRoute(page: HomeView, initial: true),
    AutoRoute(page: SignInView,),
    AutoRoute(page: ScanQrScreen)
  ]
)

class $AppRouter {}