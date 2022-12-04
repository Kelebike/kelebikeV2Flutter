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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../ui/views/view_login.dart' as _i2;
import '../../ui/views/view_splash.dart' as _i1;

class RootRouter extends _i3.RootStackRouter {
  RootRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ViewSplashRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ViewSplash(),
      );
    },
    ViewLoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.ViewLogin(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          ViewSplashRoute.name,
          path: '/splash',
        ),
        _i3.RouteConfig(
          ViewLoginRoute.name,
          path: '/login',
        ),
        _i3.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/splash',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.ViewSplash]
class ViewSplashRoute extends _i3.PageRouteInfo<void> {
  const ViewSplashRoute()
      : super(
          ViewSplashRoute.name,
          path: '/splash',
        );

  static const String name = 'ViewSplashRoute';
}

/// generated route for
/// [_i2.ViewLogin]
class ViewLoginRoute extends _i3.PageRouteInfo<void> {
  const ViewLoginRoute()
      : super(
          ViewLoginRoute.name,
          path: '/login',
        );

  static const String name = 'ViewLoginRoute';
}
