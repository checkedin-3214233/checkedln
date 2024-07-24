import 'dart:developer';

import 'package:checkedln/data/injection/dependency_injection.dart';
import 'package:checkedln/global.dart';
import 'package:checkedln/models/user/userModel.dart';
import 'package:checkedln/services/Permission/permission_phone.dart';
import 'package:checkedln/views/auth/signup.dart';
import 'package:checkedln/views/profiles/edit_profile_screen.dart';
import 'package:checkedln/views/profiles/my_profile_screen.dart';
import 'package:checkedln/views/settings/setting_page.dart';
import 'package:checkedln/views/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart' as dio;
import '../../../data/local/cache_manager.dart';
import '../../../views/auth/authentication_screen.dart';
import '../../../views/auth/make_your_profile_pop.dart';
import '../../../views/chats/user_chat_screen.dart';
import '../../../views/gallery/event_gallery.dart';
import '../../../views/home/story_view.dart';
import '../../../views/profiles/user_profile.dart';
import 'route_constant.dart';
import '../../../views/auth/get_started.dart';
import '../../../views/auth/login.dart';
import '../../../views/auth/otp_verification.dart';
import '../../../views/chats/chat_screen.dart';
import '../../../views/checkin/checkin_info.dart';
import '../../../views/checkin/checkin_screen.dart';
import '../../../views/checkin/create_checkin.dart';
import '../../../views/checkin/select_location.dart';
import '../../../views/custom_info_page.dart';
import '../../../views/home/home.dart';
import '../../../views/notification/notification_screen.dart';
import '../../../views/post/post_screen.dart';
import '../../../views/search/search_screen.dart';
import '../../../services/checkIn/check_in_services.dart';

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
            path: RoutesConstants.createCheckin,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: const CreateCheckIn(),
              );
            },
          ),
          GoRoute(
            path: RoutesConstants.selectLocation,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: SelectLocation(
                  controller: state.extra as TextEditingController,
                ),
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
            path: RoutesConstants.editProfile,
            builder: (BuildContext context, GoRouterState state) {
              return const EditProfileScreen();
            },
          ),
          GoRoute(
            path: RoutesConstants.userStroies,
            builder: (BuildContext context, GoRouterState state) {
              log("Story" + state.extra.toString());
              List<String?> list = state.extra as List<String?>;
              log("Story" + list.toString());

              return MoreStories(
                imageList: list,
              );
            },
          ),
          GoRoute(
            path: RoutesConstants.myProfile,
            builder: (BuildContext context, GoRouterState state) {
              return const MyProfileScreen();
            },
          ),
          GoRoute(
            path: RoutesConstants.authHelper,
            builder: (BuildContext context, GoRouterState state) {
              return const MakeYourProfilePop();
            },
          ),
          GoRoute(
            path: RoutesConstants.onboarding,
            builder: (BuildContext context, GoRouterState state) {
              return const AuthenticationScreen();
            },
          ),
          GoRoute(
            path: RoutesConstants.signUp,
            builder: (BuildContext context, GoRouterState state) {
              return const SignUp();
            },
          ),
          GoRoute(
            path: "${RoutesConstants.userProfile}/:id",
            builder: (BuildContext context, GoRouterState state) {
              return UserProfile(
                userId: state.pathParameters['id']!,
              );
            },
          ),
          GoRoute(
            path: "${RoutesConstants.settings}",
            builder: (BuildContext context, GoRouterState state) {
              return SettingPage();
            },
          ),
          GoRoute(
            path: "${RoutesConstants.eventGallery}",
            builder: (BuildContext context, GoRouterState state) {
              List<String> list = state.extra as List<String>;
              log("Krish$list");
              return EventGallery(
                images: list,
              );
            },
          ),
          GoRoute(
            path: "${RoutesConstants.checkin}/:id/:sharedId/:isDeep",
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String id = state.pathParameters['id']!;
              log("Kirs" + id);
              final String sharedId = state.pathParameters['sharedId']!;
              final bool isDeep =
                  state.pathParameters['isDeep']!.toLowerCase() == 'true';
              log(id.toString());
              return CustomTransitionForPage(
                key: state.pageKey,
                child: CheckInfoScreen(
                  id: id,
                  isDeep: isDeep,
                  shareId: sharedId,
                ),
              );
            },
          ),
          GoRoute(
            path: "${RoutesConstants.userChatScreen}/:userName/:userId",
            builder: (BuildContext context, GoRouterState state) {
              log("krish${state.extra}");
              return UserChatScreen(
                  id: state.pathParameters['userId']!,
                  userId: state.pathParameters['userId']!,
                  userName: state.pathParameters['userName']!,
                  profileImageUrl: state.extra as String);
            },
          ),
          GoRoute(
            path: "${RoutesConstants.shareCheckin}/:id",
            name: RoutesConstants.shareCheckin,
            redirect: _redirectCheckIn,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionForPage(
                key: state.pageKey,
                child: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
        ]);
  }

  static Future<String?> _redirectCheckIn(
      BuildContext context, GoRouterState state) async {
    final String id = state.pathParameters['id']!;
    log("Krish ${id}");
    dio.Response response = await CheckInServices().getSharedEventById(id);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "${RoutesConstants.checkin}/${response.data["shareEvent"]["event"]}/${response.data["shareEvent"]["_id"]}/${response.data["shareEvent"]["status"] == "expired" ? false : true}";
    }
    return "";
  }

  static Future<String?> _redirect(
      BuildContext context, GoRouterState state) async {
    bool? loggedIn = await getIt<CacheManager>().getLoggedIn();
    log(loggedIn.toString());
    log("message");
    final isLoginRoute = state.matchedLocation == RoutesConstants.onboarding;
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
      return RoutesConstants.onboarding;
    } else if (loggedIn) {
      print("object2");
      getIt<PermissionPhone>().requestContactPermission();

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
