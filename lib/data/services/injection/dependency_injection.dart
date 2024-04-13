import 'package:checkedln/res/colors/colors.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ColorsFile>(ColorsFile());
}
