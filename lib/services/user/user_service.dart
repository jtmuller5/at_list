import 'dart:developer';

import 'package:at_list/services/services.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserService{

  // Keys
  static const String atSignKey = 'at_sign';

  String get currentAtSign{
    return atProtocolService.currentAtSign;
  }

  String get userBoxId{
    return 'at_user';
  }

  Box get userBox{
    return Hive.box(userBoxId);
  }

  Future<void> initializeUserService() async {
    log('setting up user service');
    await Hive.openBox(userBoxId);
    log('user box open: ' + Hive.isBoxOpen(userBoxId).toString());
  }

  String get atSign{
    return userBox.get(UserService.atSignKey);
  }
}