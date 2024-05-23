import 'package:checkedln/data/local/cache_manager.dart';
import 'package:checkedln/global_index.dart';
import 'package:checkedln/services/notiication/one_signal_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'data/injection/dependency_injection.dart';
import 'res/colors/colors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  setup();

  await getIt<CacheManager>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getIt<OneSignalServices>().context = context;

    return ScreenUtilInit(builder: (_, context) {
      return GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        key: navigatorKey,
        title: 'Checkedln',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(),
          primaryTextTheme: GoogleFonts.nunitoTextTheme(),
          colorScheme:
              ColorScheme.fromSeed(seedColor: getIt<ColorsFile>().primaryColor),
          useMaterial3: true,
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      );
    });
  }
}
