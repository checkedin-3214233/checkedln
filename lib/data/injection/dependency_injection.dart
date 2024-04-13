import 'package:checkedln/res/colors/colors.dart';
import 'package:get_it/get_it.dart';

import '../local/cache_manager.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ColorsFile>(ColorsFile());
  getIt.registerSingleton<CacheManager>(CacheManager());
}
