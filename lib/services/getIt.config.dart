// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'at/at_protocol_service.dart';
import 'at/attached_service.dart';
import 'app/system_service.dart';
import 'app/theme_Service.dart';
import 'app/toast_service.dart';
import 'user/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<ThemeService>(() => ThemeService());
  gh.factory<ToastService>(() => ToastService());

  // Eager singletons must be registered in the right order
  gh.singleton<AtProtocolService>(AtProtocolService());
  gh.singleton<AttachedService>(AttachedService());
  gh.singleton<SystemService>(SystemService());
  gh.singleton<UserService>(UserService());
  return get;
}
