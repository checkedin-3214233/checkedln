import 'package:checkedln/res/colors/colors.dart';
import 'package:get_it/get_it.dart';

import '../../services/socket_services.dart';
import '../local/cache_manager.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ColorsFile>(ColorsFile());
  getIt.registerSingleton<CacheManager>(CacheManager());
  getIt.registerSingleton<SocketServices>(SocketServices());
}
