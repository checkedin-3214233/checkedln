import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
export 'global.dart';
import 'services/routes_genratotor.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

BuildContext? get ctx => router.routerDelegate.navigatorKey.currentContext;
final GoRouter router = RoutesGenerator.onGenerateRoutes();
