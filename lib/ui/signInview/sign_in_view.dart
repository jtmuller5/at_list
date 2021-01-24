import 'package:at_list/ui/signInview/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {

  static const String id = 'sign_in_view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
            body: Column(
              children: [
                Container()
              ],
            )
        );
      },
    );
  }
}