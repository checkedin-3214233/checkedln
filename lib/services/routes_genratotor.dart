import 'dart:developer';

import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/views/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../data/local/cache_manager.dart';
import '../res/colors/routes/route_constant.dart';
import '../views/auth/get_started.dart';
import '../views/auth/login.dart';
import '../views/auth/otp_verification.dart';
import '../views/chats/chat_screen.dart';
import '../views/checkin/checkin_info.dart';
import '../views/checkin/checkin_screen.dart';
import '../views/custom_info_page.dart';
import '../views/home/home.dart';
import '../views/notification/notification_screen.dart';
import '../views/post/post_screen.dart';
import '../views/search/search_screen.dart';

class RoutesGenerator {
  static String? initialMatchedLocation;
  static RxString goToRoute = "".obs;

  static GoRouter onGenerateRoutes() {
    return GoRouter(
        initialLocation: RoutesConstants.splash,
        errorPageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionForPage(
            key: state.pageKey,
            child: CustomInfoPage(
              icon: 'assets/icons/page_not_found.svg',
              title: 'Page Not Found.',
              message:
                  "Oops! Looks like you took a wrong turn. The page you're looking for can't be found.",
              buttonText: 'Back Home',
              buttonTextOnTap: () {
                ctx!.pushReplacement(RoutesConstants.home);
              },
              secondButtonOnTap: () {},
            ),
          );
        },
        routes: [
          GoRoute(
            redirect: _redirect,
            path: RoutesConstants.splash,
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            },
          ),
          GoRoute(
            path: RoutesConstants.search,
            builder: (BuildContext context, GoRouterState state) {
              return const SearchScreen();
            },
          ),
          GoRoute(
            path: RoutesConstants.chat,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: const ChatScreen(),
              );
            },
          ),
          GoRoute(
            path: RoutesConstants.post,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: const PostScreen(),
              );
            },
          ),
          GoRoute(
            path: RoutesConstants.allCheckin,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: const CheckInScreen(),
              );
            },
          ),
          GoRoute(
            path: RoutesConstants.notification,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: const NotificationScreen(),
              );
            },
          ),
          GoRoute(
            path: RoutesConstants.home,
            builder: (BuildContext context, GoRouterState state) {
              return Home();
            },
          ),
          GoRoute(
            path: RoutesConstants.login,
            builder: (BuildContext context, GoRouterState state) {
              return const Login();
            },
          ),
          GoRoute(
            path: RoutesConstants.otp,
            name: RoutesConstants.otp,
            builder: (BuildContext context, GoRouterState state) {
              return OtpVerification();
            },
          ),
          GoRoute(
            path: RoutesConstants.createProfile,
            builder: (BuildContext context, GoRouterState state) {
              return const GetStarted();
            },
          ),
          GoRoute(
            path: "${RoutesConstants.checkin}/:id",
            name: RoutesConstants.checkin,
            pageBuilder: (BuildContext context, GoRouterState state) {
              log(state.extra.toString());
              final String id = state.pathParameters['id']!;

              return CustomTransitionForPage(
                key: state.pageKey,
                child: CheckInfoScreen(
                  id: id,
                  isDeep: false,
                ),
              );
            },
          ),
          GoRoute(
            path: "${RoutesConstants.shareCheckin}/:id",
            name: RoutesConstants.shareCheckin,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String id = state.pathParameters['id']!;
              log("Krish ${id}");
              return CustomTransitionForPage(
                key: state.pageKey,
                child: CheckInfoScreen(
                  id: id,
                  isDeep: true,
                ),
              );
            },
          ),
        ]);
  }

  static Future<String?> _redirect(
      BuildContext context, GoRouterState state) async {
    bool? loggedIn = await getIt<CacheManager>().getLoggedIn();
    log(loggedIn.toString());
    log("message");
    final isLoginRoute = state.matchedLocation == RoutesConstants.login;
    bool isHomeRoute = state.matchedLocation == RoutesConstants.home;

    // Update the values of matchedLocation and isHomeRoute
    String matchedLocation = state.matchedLocation;
    isHomeRoute = isHomeRoute;

    // Initialize initialMatchedLocation if it is null
    initialMatchedLocation ??= state.matchedLocation;

    bool someBool = matchedLocation.isEmpty && isHomeRoute;
    goToRoute.value = someBool ? RoutesConstants.home : matchedLocation;

    // List of routes that should be accessible even when the user is not logged in
    final allowedRoutes = [
      RoutesConstants.onboarding,
      RoutesConstants.login,
      RoutesConstants.otp,
      RoutesConstants.createProfile,
      RoutesConstants.resetPassword,
      RoutesConstants.onboarding,
      RoutesConstants.home,
    ];

    // Check if the current route is in the list of allowed routes
    if (!loggedIn!) {
      print("object1");
      return RoutesConstants.login;
    } else if (loggedIn) {
      print("object2");
      return RoutesConstants.home;
    } else if (loggedIn && isHomeRoute) {
      print("object");
      return null;
    }

    return null;
  }
}

class CustomTransitionForPage<T> extends Page<T> {
  final Widget child;

  const CustomTransitionForPage({required this.child, required LocalKey key})
      : super(key: key);

  @override
  Route<T> createRoute(BuildContext context) {
    return CupertinoPageRoute<T>(
      builder: (BuildContext context) => this.child,
      settings: this,
    );
  }
}
