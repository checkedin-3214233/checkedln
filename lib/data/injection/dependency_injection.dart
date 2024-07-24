import 'package:checkedln/res/colors/colors.dart';
import 'package:get_it/get_it.dart';

import '../../services/Permission/permission_phone.dart';
import '../../services/location/location_service.dart';
import '../../services/notiication/one_signal_services.dart';
import '../../services/socket_services.dart';
import '../local/cache_manager.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ColorsFile>(ColorsFile());
  getIt.registerSingleton<CacheManager>(CacheManager());

  getIt.registerSingleton<SocketServices>(SocketServices());
  getIt.registerSingleton<OneSignalServices>(OneSignalServices());

  getIt.registerFactory<LocationService>(() => LocationService());
  getIt.registerFactory<PermissionPhone>(() => PermissionPhone());
}
