// Called after the user is authenticated since these services need to be
// Initialized on a per user basis
import 'package:at_list/services/app/system_service.dart';
import 'package:at_list/services/app/theme_Service.dart';
import 'package:at_list/services/app/toast_service.dart';
import 'package:at_list/services/at/at_protocol_service.dart';
import 'package:at_list/services/at/attached_service.dart';
import 'package:at_list/services/getIt.dart';
import 'package:at_list/services/settings/settings_service.dart';
import 'package:at_list/services/user/user_service.dart';

Future<void> initializeServices() async {
  try {
    // Throws errors if adapters are already registered
    //if(!Hive.isAdapterRegistered(1)) Hive.registerAdapter(PostAdapter());
    //if(!Hive.isAdapterRegistered(2)) Hive.registerAdapter(UserAdapter());

    await userService.initializeUserService();
  } catch(e){
    print('initializing error: ' + e.toString());
  }
}

UserService get userService {
  return getIt.get<UserService>();
}

SettingsService get userFaunaService {
  return getIt.get<SettingsService>();
}

SystemService get systemService {
  return getIt.get<SystemService>();
}

ThemeService get themeService {
  return getIt.get<ThemeService>();
}

ToastService get toastService {
  return getIt.get<ToastService>();
}

AtProtocolService get atProtocolService {
  return getIt.get<AtProtocolService>();
}

AttachedService get attachedService {
  return getIt.get<AttachedService>();
}