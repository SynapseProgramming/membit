// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:membit/deckmenuscreen.dart' as _i4;
import 'package:membit/deckscreen.dart' as _i3;
import 'package:membit/homescreen.dart' as _i2;
import 'package:membit/main.dart' as _i1;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DashboardScreen(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomeScreen(),
      );
    },
    CreatedeckRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CreatedeckScreen(),
      );
    },
    DeckRouterRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DeckRouterScreen(),
      );
    },
    DeckListRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DeckListScreen(),
      );
    },
    DeckRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DeckScreen(),
      );
    },
    DeckMenuRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DeckMenuScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashboardScreen]
class DashboardRoute extends _i5.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          DashboardRoute.name,
          args: DashboardRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i5.PageInfo<DashboardRouteArgs> page =
      _i5.PageInfo<DashboardRouteArgs>(name);
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CreatedeckScreen]
class CreatedeckRoute extends _i5.PageRouteInfo<void> {
  const CreatedeckRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CreatedeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedeckRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DeckRouterScreen]
class DeckRouterRoute extends _i5.PageRouteInfo<void> {
  const DeckRouterRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DeckRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckRouterRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DeckListScreen]
class DeckListRoute extends _i5.PageRouteInfo<void> {
  const DeckListRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DeckListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckListRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DeckScreen]
class DeckRoute extends _i5.PageRouteInfo<void> {
  const DeckRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DeckMenuScreen]
class DeckMenuRoute extends _i5.PageRouteInfo<void> {
  const DeckMenuRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DeckMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckMenuRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
