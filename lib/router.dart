import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: DashboardRoute.page, children: [
          AutoRoute(path: 'home', page: HomeRoute.page),
          AutoRoute(path: 'deckroute', page: DeckRouterRoute.page, children: [
            AutoRoute(
                path: 'deck',
                page: DeckRoute.page,
                children: [
                  AutoRoute(
                      path: 'list', page: DeckListRoute.page, initial: true),
                  AutoRoute(path: 'create', page: CreatedeckRoute.page),
                ],
                initial: true),
            AutoRoute(path: 'deckmenu', page: DeckMenuRoute.page),
            AutoRoute(path: 'addcard', page: AddCardRoute.page),
            AutoRoute(path: 'deletecard', page: DeleteCardRoute.page),
            AutoRoute(path: 'deletedeck', page: DeleteDeckRoute.page),
            AutoRoute(path: 'cardshow', page: CardShowRoute.page),
            AutoRoute(path: 'addgpt', page: GptAddRoute.page),
            AutoRoute(path: 'generatedcards', page: GeneratedCardRoute.page),
            AutoRoute(path: 'editcard', page: EditCardRoute.page)
          ])
        ])
      ];
}
