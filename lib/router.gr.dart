// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:membit/cardshowscreen.dart' as _i2;
import 'package:membit/deckmenuscreen.dart' as _i4;
import 'package:membit/deckscreen.dart' as _i5;
import 'package:membit/homescreen.dart' as _i1;
import 'package:membit/main.dart' as _i3;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeScreen(),
      );
    },
    CardShowRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CardShowScreen(),
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DashboardScreen(key: args.key),
      );
    },
    DeleteCardRoute.name: (routeData) {
      final args = routeData.argsAs<DeleteCardRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeleteCardScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    AddCardRoute.name: (routeData) {
      final args = routeData.argsAs<AddCardRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AddCardScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    DeckMenuRoute.name: (routeData) {
      final args = routeData.argsAs<DeckMenuRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeckMenuScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    DeleteDeckRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeleteDeckScreen(),
      );
    },
    CreatedeckRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CreatedeckScreen(),
      );
    },
    DeckRouterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeckRouterScreen(),
      );
    },
    DeckListRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeckListScreen(),
      );
    },
    DeckRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeckScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CardShowScreen]
class CardShowRoute extends _i6.PageRouteInfo<void> {
  const CardShowRoute({List<_i6.PageRouteInfo>? children})
      : super(
          CardShowRoute.name,
          initialChildren: children,
        );

  static const String name = 'CardShowRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i6.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          DashboardRoute.name,
          args: DashboardRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i6.PageInfo<DashboardRouteArgs> page =
      _i6.PageInfo<DashboardRouteArgs>(name);
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.DeleteCardScreen]
class DeleteCardRoute extends _i6.PageRouteInfo<DeleteCardRouteArgs> {
  DeleteCardRoute({
    _i7.Key? key,
    required String DeckName,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          DeleteCardRoute.name,
          args: DeleteCardRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'DeleteCardRoute';

  static const _i6.PageInfo<DeleteCardRouteArgs> page =
      _i6.PageInfo<DeleteCardRouteArgs>(name);
}

class DeleteCardRouteArgs {
  const DeleteCardRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i7.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'DeleteCardRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i4.AddCardScreen]
class AddCardRoute extends _i6.PageRouteInfo<AddCardRouteArgs> {
  AddCardRoute({
    _i7.Key? key,
    required String DeckName,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          AddCardRoute.name,
          args: AddCardRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCardRoute';

  static const _i6.PageInfo<AddCardRouteArgs> page =
      _i6.PageInfo<AddCardRouteArgs>(name);
}

class AddCardRouteArgs {
  const AddCardRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i7.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'AddCardRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i4.DeckMenuScreen]
class DeckMenuRoute extends _i6.PageRouteInfo<DeckMenuRouteArgs> {
  DeckMenuRoute({
    _i7.Key? key,
    required String DeckName,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          DeckMenuRoute.name,
          args: DeckMenuRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'DeckMenuRoute';

  static const _i6.PageInfo<DeckMenuRouteArgs> page =
      _i6.PageInfo<DeckMenuRouteArgs>(name);
}

class DeckMenuRouteArgs {
  const DeckMenuRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i7.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'DeckMenuRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i5.DeleteDeckScreen]
class DeleteDeckRoute extends _i6.PageRouteInfo<void> {
  const DeleteDeckRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DeleteDeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeleteDeckRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CreatedeckScreen]
class CreatedeckRoute extends _i6.PageRouteInfo<void> {
  const CreatedeckRoute({List<_i6.PageRouteInfo>? children})
      : super(
          CreatedeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedeckRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DeckRouterScreen]
class DeckRouterRoute extends _i6.PageRouteInfo<void> {
  const DeckRouterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DeckRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckRouterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DeckListScreen]
class DeckListRoute extends _i6.PageRouteInfo<void> {
  const DeckListRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DeckListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckListRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DeckScreen]
class DeckRoute extends _i6.PageRouteInfo<void> {
  const DeckRoute({List<_i6.PageRouteInfo>? children})
      : super(
          DeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
