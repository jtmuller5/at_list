import 'dart:io';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_list/app/at_constants.dart';
import 'package:at_list/app/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

@singleton
class AtProtocolService {
  /// The current AtClientService used to initialize the AtClient
  AtClientService atClientService;

  /// The current AtClient implementation
  AtClientImpl atClientImpl;

  /// The currently logged in @Sign
  String atSign;

  KeyChainManager manager;

  /// List of @Signs available on this device
  List<String> atSignList = [];

  AtClientPreference atClientPreference;

  String get currentAtSign {
    return atClientService.atClient.currentAtSign;
  }

  GlobalKey<NavigatorState> navKey = GlobalKey();

  Future<void> setup() async {
    await getSigns();
  }

  /// Get all @Signs that this device has used to sign in
  Future<void> getSigns() async {
    manager = KeyChainManager.getInstance();
    atSignList = await manager.getAtSignListFromKeychain();
  }

  /// make the selected atSign the primary one before onboarding again
  Future<void> makePrimary(String atSign) async {
    await manager.makeAtSignPrimary(atSign);
  }

  Future<bool> onboard({String atsign}) async {
    atClientImpl = null;
    atSign = null;
    atClientService = AtClientService();
    Directory downloadDirectory;

    /// The directory where keys will be stored
    if (Platform.isIOS) {
      downloadDirectory =
          await path_provider.getApplicationDocumentsDirectory();
    }

    /// Download path varies on non-iOS platforms
    else {
      downloadDirectory = await path_provider.getExternalStorageDirectory();
    }

    final appSupportDirectory =
        await path_provider.getApplicationSupportDirectory();

    String path = appSupportDirectory.path;


    /// Setup AtClient preferences (cascade for cleanliness)
    atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = path
      ..syncStrategy = SyncStrategy.IMMEDIATE
      ..rootDomain = AtConstants.ROOT_DOMAIN
      ..hiveStoragePath = path
      ..downloadPath = downloadDirectory.path;

    var result = await atClientService
        .onboard(atClientPreference: atClientPreference, atsign: atsign)
        .catchError((e) => print('Error in Onboarding: $e'));

    print('result: ' + result.toString());
    if(result == null){
      result = false;
    }

    /// Store the current At Sign for display
    atSign = await atClientService.getAtSign();

    return result;
  }

  ///Fetches atsign from device keychain.
  Future<String> getAtSign() async {
    return await atClientService.getAtSign();
  }

  Future<String> get(AtKey atKey) async {
    var result = await atClientImpl.get(atKey);
    return result.value;
  }

  Future<bool> put(AtKey atKey, String value) async {
    return await atClientImpl.put(
      atKey,
      value,
    );
  }

  Future<bool> delete(AtKey atKey) async {
    return await atClientImpl.delete(atKey);
  }

  Future<List<String>> getKeys({String sharedBy}) async {
    return await atClientImpl
        .getKeys(regex: 'server_demo', sharedBy: sharedBy);
  }

  Future<bool> saveKeys(String publicKey, String privateKey) {
    return atClientImpl.persistPublicKey(publicKey);
  }

  /// Clear all At Protocol values and return to the initial sign in view
  void logout(BuildContext context){
    atClientService = null;
    atClientImpl = null;
    atClientPreference = null;
    atSign = null;

    ExtendedNavigator.of(context).pushAndRemoveUntil(Routes.signInView,(route) => false);
  }
}
