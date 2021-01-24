import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

/// Service for displaying toasts, snackbars, banners, or other
/// temporary info boxes
///
/// Also has functions to manage the keyboard

@injectable
class ToastService {
  void showSnackbar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  /// Function to show a toast
  Future<void> showToast(
    String message, {
    Color color = Colors.blueAccent,
    Color textColor = Colors.white,
    double fontSize = 16,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    bool cancel = true,
  }) async {
    /// Cancel all other toasts if cancel flag is true
    if(cancel){
      Fluttertoast.cancel();
    }

    await Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: textColor,
        fontSize: fontSize);
  }

  /// Simple function to close the keyboard. Used before showing a snackbar
  void closeKeyboard(BuildContext context) {
    FocusScope.of(context)
        .requestFocus(FocusNode()); // Unfocus text fields on page change
  }

  /// Check if keyboard is open
  bool keyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }
}
