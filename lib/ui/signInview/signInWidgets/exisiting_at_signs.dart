import 'package:at_list/app/router.gr.dart';
import 'package:at_list/services/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../sign_in_view_model.dart';

class ExistingAtSigns extends ViewModelWidget<SignInViewModel> {
  @override
  Widget build(BuildContext context, SignInViewModel model) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 300,
            child: Text(
              'We also found these @signs on your device',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Sign in as...'),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (String sign in atProtocolService.atSignList)
                OutlineButton(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                    child: Text('$sign'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),),
                    onPressed: () async {
                      await atProtocolService.makePrimary(sign);
                      await atProtocolService.onboard().then((success) {
                        if (success) {
                          ExtendedNavigator.of(context)
                              .replace(Routes.homeView);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Sorry...something went wrong'),
                          ));
                        }
                      });
                    })
            ],
          ))
        ],
      ),
    );
  }
}
