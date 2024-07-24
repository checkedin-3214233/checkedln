import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/data/local/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

import '../../controller/settings_controler.dart';
import '../../res/colors/routes/route_constant.dart';
import '../widget_helper.dart';
import 'setting_widget_helper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingsController _settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar("Settings", [], SizedBox.shrink(), false),
      body: SafeArea(
          child: ListView(
        children: [
          for (int i = 0; i < _settingsController.features.length; i++) ...[
            threeTile(SvgPicture.asset(_settingsController.features[i]["icon"]),
                _settingsController.features[i]["title"], () {
              if (_settingsController.features[i]["title"] == "Logout") {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("No")),
                          TextButton(
                              onPressed: () async {
                                ctx.pop();
                                getIt<CacheManager>().setLoggedIn(false);
                                getIt<CacheManager>().setToken("", "");
                                getIt<CacheManager>().setUserId("");
                                await getIt.reset();
                                Get.reset();

                                ctx.pushReplacement(RoutesConstants.onboarding);
                                Restart.restartApp();
                              },
                              child: Text("Yes"))
                        ],
                      );
                    });
              }
            })
          ]
        ],
      )),
    );
  }
}
