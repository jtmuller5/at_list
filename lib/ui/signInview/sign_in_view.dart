import 'package:at_list/app/router.gr.dart';
import 'package:at_list/services/services.dart';
import 'package:at_list/ui/homeView/home_view.dart';
import 'package:at_list/ui/signInview/signInWidgets/exisiting_at_signs.dart';
import 'package:at_list/ui/signInview/sign_in_view_model.dart';
import 'package:atsign_authentication_helper/screens/scan_qr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('sign in view built');
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
              body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, Colors.white],
                    stops: [0, .5],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Icon(
                      Icons.alternate_email_outlined,
                      size: 100,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          child: Text('Use Existing @ Sign'),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onPressed: () async {
                            await ExtendedNavigator.of(context).replace(
                              Routes.scanQrScreen,
                              arguments: ScanQrScreenArguments(
                                  nextScreen: HomeView(),
                                  atClientServiceInstance:
                                      atProtocolService.atClientService,
                                  atClientPreference:
                                      atProtocolService.atClientPreference),
                            );
                          },
                        ),
                        RaisedButton(
                            child: Text('Get a New @ Sign'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            onPressed: () {
                              //atProtocolService.onboard();
                            }),
                      ],
                    ),
                  ),
                  if (atProtocolService.atSignList.isNotEmpty) ExistingAtSigns()
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
