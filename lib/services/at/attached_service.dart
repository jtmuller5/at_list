import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AttachedService extends ChangeNotifier {
  String myAtSign;
  String theirAtSign;

  String mySign;
  String theirSign; // No @ symbol

}
