// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../../ui/views/sign_in.dart' as _i3;
import '../../ui/views/view_login.dart' as _i2;
import '../../ui/views/view_splash.dart' as _i1;

class RootRouter extends _i4.RootStackRouter {
  RootRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ViewSplashRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ViewSplash(),
      );
    },
    ViewLoginRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.ViewLogin(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.SignIn(key: args.key),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          ViewSplashRoute.name,
          path: '/splash',
        ),
        _i4.RouteConfig(
          ViewLoginRoute.name,
          path: '/login',
        ),
        _i4.RouteConfig(
          SignInRoute.name,
          path: '/sign_in',
        ),
        _i4.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/splash',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.ViewSplash]
class ViewSplashRoute extends _i4.PageRouteInfo<void> {
  const ViewSplashRoute()
      : super(
          ViewSplashRoute.name,
          path: '/splash',
        );

  static const String name = 'ViewSplashRoute';
}

/// generated route for
/// [_i2.ViewLogin]
class ViewLoginRoute extends _i4.PageRouteInfo<void> {
  const ViewLoginRoute()
      : super(
          ViewLoginRoute.name,
          path: '/login',
        );

  static const String name = 'ViewLoginRoute';
}

/// generated route for
/// [_i3.SignIn]
class SignInRoute extends _i4.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({_i5.Key? key})
      : super(
          SignInRoute.name,
          path: '/sign_in',
          args: SignInRouteArgs(key: key),
        );

  static const String name = 'SignInRoute';
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}
