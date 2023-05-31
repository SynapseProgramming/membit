// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:membit/cardshowscreen.dart' as _i2;
import 'package:membit/deckmenuscreen.dart' as _i4;
import 'package:membit/deckscreen.dart' as _i5;
import 'package:membit/entities/card.dart' as _i10;
import 'package:membit/entities/deck.dart' as _i9;
import 'package:membit/gptaddscreen.dart' as _i6;
import 'package:membit/homescreen.dart' as _i1;
import 'package:membit/main.dart' as _i3;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeScreen(),
      );
    },
    CardShowRoute.name: (routeData) {
      final args = routeData.argsAs<CardShowRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CardShowScreen(
          key: args.key,
          currentDeck: args.currentDeck,
        ),
      );
    },
    DashboardRoute.name: (routeData) {
      final args = routeData.argsAs<DashboardRouteArgs>(
          orElse: () => const DashboardRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DashboardScreen(key: args.key),
      );
    },
    DeleteCardRoute.name: (routeData) {
      final args = routeData.argsAs<DeleteCardRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeleteCardScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    AddCardRoute.name: (routeData) {
      final args = routeData.argsAs<AddCardRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AddCardScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    EditCardRoute.name: (routeData) {
      final args = routeData.argsAs<EditCardRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.EditCardScreen(
          key: args.key,
          card: args.card,
        ),
      );
    },
    DeckMenuRoute.name: (routeData) {
      final args = routeData.argsAs<DeckMenuRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeckMenuScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    DeleteDeckRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeleteDeckScreen(),
      );
    },
    CreatedeckRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CreatedeckScreen(),
      );
    },
    DeckRouterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeckRouterScreen(),
      );
    },
    DeckListRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeckListScreen(),
      );
    },
    DeckRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DeckScreen(),
      );
    },
    GptAddRoute.name: (routeData) {
      final args = routeData.argsAs<GptAddRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.GptAddScreen(
          key: args.key,
          DeckName: args.DeckName,
        ),
      );
    },
    GeneratedCardRoute.name: (routeData) {
      final args = routeData.argsAs<GeneratedCardRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.GeneratedCardScreen(
          key: args.key,
          cards: args.cards,
          DeckName: args.DeckName,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CardShowScreen]
class CardShowRoute extends _i7.PageRouteInfo<CardShowRouteArgs> {
  CardShowRoute({
    _i8.Key? key,
    required _i9.Deck currentDeck,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          CardShowRoute.name,
          args: CardShowRouteArgs(
            key: key,
            currentDeck: currentDeck,
          ),
          initialChildren: children,
        );

  static const String name = 'CardShowRoute';

  static const _i7.PageInfo<CardShowRouteArgs> page =
      _i7.PageInfo<CardShowRouteArgs>(name);
}

class CardShowRouteArgs {
  const CardShowRouteArgs({
    this.key,
    required this.currentDeck,
  });

  final _i8.Key? key;

  final _i9.Deck currentDeck;

  @override
  String toString() {
    return 'CardShowRouteArgs{key: $key, currentDeck: $currentDeck}';
  }
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i7.PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DashboardRoute.name,
          args: DashboardRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i7.PageInfo<DashboardRouteArgs> page =
      _i7.PageInfo<DashboardRouteArgs>(name);
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.DeleteCardScreen]
class DeleteCardRoute extends _i7.PageRouteInfo<DeleteCardRouteArgs> {
  DeleteCardRoute({
    _i8.Key? key,
    required String DeckName,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DeleteCardRoute.name,
          args: DeleteCardRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'DeleteCardRoute';

  static const _i7.PageInfo<DeleteCardRouteArgs> page =
      _i7.PageInfo<DeleteCardRouteArgs>(name);
}

class DeleteCardRouteArgs {
  const DeleteCardRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i8.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'DeleteCardRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i4.AddCardScreen]
class AddCardRoute extends _i7.PageRouteInfo<AddCardRouteArgs> {
  AddCardRoute({
    _i8.Key? key,
    required String DeckName,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          AddCardRoute.name,
          args: AddCardRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCardRoute';

  static const _i7.PageInfo<AddCardRouteArgs> page =
      _i7.PageInfo<AddCardRouteArgs>(name);
}

class AddCardRouteArgs {
  const AddCardRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i8.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'AddCardRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i4.EditCardScreen]
class EditCardRoute extends _i7.PageRouteInfo<EditCardRouteArgs> {
  EditCardRoute({
    _i8.Key? key,
    required _i10.Card card,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          EditCardRoute.name,
          args: EditCardRouteArgs(
            key: key,
            card: card,
          ),
          initialChildren: children,
        );

  static const String name = 'EditCardRoute';

  static const _i7.PageInfo<EditCardRouteArgs> page =
      _i7.PageInfo<EditCardRouteArgs>(name);
}

class EditCardRouteArgs {
  const EditCardRouteArgs({
    this.key,
    required this.card,
  });

  final _i8.Key? key;

  final _i10.Card card;

  @override
  String toString() {
    return 'EditCardRouteArgs{key: $key, card: $card}';
  }
}

/// generated route for
/// [_i4.DeckMenuScreen]
class DeckMenuRoute extends _i7.PageRouteInfo<DeckMenuRouteArgs> {
  DeckMenuRoute({
    _i8.Key? key,
    required String DeckName,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DeckMenuRoute.name,
          args: DeckMenuRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'DeckMenuRoute';

  static const _i7.PageInfo<DeckMenuRouteArgs> page =
      _i7.PageInfo<DeckMenuRouteArgs>(name);
}

class DeckMenuRouteArgs {
  const DeckMenuRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i8.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'DeckMenuRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i5.DeleteDeckScreen]
class DeleteDeckRoute extends _i7.PageRouteInfo<void> {
  const DeleteDeckRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DeleteDeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeleteDeckRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CreatedeckScreen]
class CreatedeckRoute extends _i7.PageRouteInfo<void> {
  const CreatedeckRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CreatedeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedeckRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DeckRouterScreen]
class DeckRouterRoute extends _i7.PageRouteInfo<void> {
  const DeckRouterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DeckRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckRouterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DeckListScreen]
class DeckListRoute extends _i7.PageRouteInfo<void> {
  const DeckListRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DeckListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckListRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DeckScreen]
class DeckRoute extends _i7.PageRouteInfo<void> {
  const DeckRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DeckRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeckRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.GptAddScreen]
class GptAddRoute extends _i7.PageRouteInfo<GptAddRouteArgs> {
  GptAddRoute({
    _i8.Key? key,
    required String DeckName,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          GptAddRoute.name,
          args: GptAddRouteArgs(
            key: key,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'GptAddRoute';

  static const _i7.PageInfo<GptAddRouteArgs> page =
      _i7.PageInfo<GptAddRouteArgs>(name);
}

class GptAddRouteArgs {
  const GptAddRouteArgs({
    this.key,
    required this.DeckName,
  });

  final _i8.Key? key;

  final String DeckName;

  @override
  String toString() {
    return 'GptAddRouteArgs{key: $key, DeckName: $DeckName}';
  }
}

/// generated route for
/// [_i6.GeneratedCardScreen]
class GeneratedCardRoute extends _i7.PageRouteInfo<GeneratedCardRouteArgs> {
  GeneratedCardRoute({
    _i8.Key? key,
    required List<_i10.Card> cards,
    required String DeckName,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          GeneratedCardRoute.name,
          args: GeneratedCardRouteArgs(
            key: key,
            cards: cards,
            DeckName: DeckName,
          ),
          initialChildren: children,
        );

  static const String name = 'GeneratedCardRoute';

  static const _i7.PageInfo<GeneratedCardRouteArgs> page =
      _i7.PageInfo<GeneratedCardRouteArgs>(name);
}

class GeneratedCardRouteArgs {
  const GeneratedCardRouteArgs({
    this.key,
    required this.cards,
    required this.DeckName,
  });

  final _i8.Key? key;

  final List<_i10.Card> cards;

  final String DeckName;

  @override
  String toString() {
    return 'GeneratedCardRouteArgs{key: $key, cards: $cards, DeckName: $DeckName}';
  }
}
