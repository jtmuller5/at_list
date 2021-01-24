import 'dart:io';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_list/app/at_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

@singleton
class AtProtocolService {
  AtClientService atClientServiceInstance;

  AtClientImpl atClientInstance;

  AtClientPreference atClientPreference;

  String get currentAtSign {
    return atClientInstance.currentAtSign;
  }

  Future<void> setupAtProtocol() async {
    atClientServiceInstance = AtClientService();
    try {
      await onboard();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> onboard({String atsign}) async {
    atClientServiceInstance = AtClientService();
    Directory downloadDirectory;
    if (Platform.isIOS) {
      downloadDirectory =
          await path_provider.getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = await path_provider.getExternalStorageDirectory();
    }

    final appSupportDirectory =
        await path_provider.getApplicationSupportDirectory();
    String path = appSupportDirectory.path;
    atClientPreference = AtClientPreference();

    atClientPreference.isLocalStoreRequired = true;
    atClientPreference.commitLogPath = path;
    atClientPreference.syncStrategy = SyncStrategy.IMMEDIATE;
    atClientPreference.rootDomain = AtConstants.ROOT_DOMAIN;
    atClientPreference.hiveStoragePath = path;
    atClientPreference.downloadPath = downloadDirectory.path;
    var result = await atClientServiceInstance
        .onboard(atClientPreference: atClientPreference, atsign: atsign)
        .catchError((e) => print('Error in Onboarding: $e'));
    return result;
  }

  ///Returns `false` if fails in authenticating [atsign] with [cramSecret]/[privateKey].
  Future<bool> authenticate(String atsign,
      {String cramSecret, String privateKey}) async {
    var result = await atClientServiceInstance.authenticate(atsign, atClientPreference);

    return result;
  }

  ///Fetches atsign from device keychain.
  Future<String> getAtSign() async {
    return await atClientServiceInstance.getAtSign();
  }

  Future<String> get(AtKey atKey) async {
    var result = await atClientInstance.get(atKey);
    return result.value;
  }

  Future<bool> put(AtKey atKey, String value) async {
    return await atClientInstance.put(
      atKey,
      value,
    );
  }

  Future<bool> delete(AtKey atKey) async {
    return await atClientInstance.delete(atKey);
  }

  Future<List<String>> getKeys({String sharedBy}) async {
    return await atClientInstance.getKeys(
        regex: 'server_demo', sharedBy: sharedBy);
  }

  Future<bool> saveKeys(String publicKey, String privateKey) {
    return atClientInstance.persistPublicKey(publicKey);
  }
}
