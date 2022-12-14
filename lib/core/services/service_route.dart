
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelebikev2/ui/views/sign_in.dart';

import '../../ui/views/view_login.dart';
import '../../ui/views/view_splash.dart';

export 'service_route.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(path: '/splash', page: ViewSplash),
    AutoRoute(path: '/login', page: ViewLogin),
    AutoRoute(path: '/sign_in', page:SignIn),

    RedirectRoute(path: '*', redirectTo: '/splash'),
  ],
)
class $RootRouter {}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('didPush: ${route.isActive.toString()}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('didPop: ${route.isActive.toString()} ${previousRoute!.isActive.toString()}');
  }
}
