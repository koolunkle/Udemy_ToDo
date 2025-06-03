import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/presentation/core/go_router_observer.dart';
import 'package:todo/presentation/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo/presentation/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo/presentation/pages/dashboard/dashboard_page.dart';
import 'package:todo/presentation/pages/detail/todo_detail_page.dart';
import 'package:todo/presentation/pages/home/home_page.dart';
import 'package:todo/presentation/pages/overview/overview_page.dart';
import 'package:todo/presentation/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'sheel',
);

const String _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/${DashboardPage.pageConfig.name}',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.name,
      path: '$_basePath/${SettingsPage.pageConfig.name}',
      builder: (context, state) => SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: '$_basePath/:tab',
          builder:
              (context, state) => HomePage(
                key: state.pageKey,
                tab: state.pathParameters['tab'] ?? 'dashboard',
              ),
        ),
      ],
    ),
    GoRoute(
      name: CreateToDoCollectionPage.pageConfig.name,
      path:
          '$_basePath/${OverviewPage.pageConfig.name}/${CreateToDoCollectionPage.pageConfig.name}',
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('create collection'),
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(
                      HomePage.pageConfig.name,
                      pathParameters: {'tab': OverviewPage.pageConfig.name},
                    );
                  }
                },
              ),
            ),
            body: SafeArea(child: CreateToDoCollectionPage.pageConfig.child),
          ),
    ),
    GoRoute(
      name: CreateToDoEntryPage.pageConfig.name,
      path:
          '$_basePath/${OverviewPage.pageConfig.name}/${CreateToDoEntryPage.pageConfig.name}',
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('create collection'),
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(
                      HomePage.pageConfig.name,
                      pathParameters: {'tab': OverviewPage.pageConfig.name},
                    );
                  }
                },
              ),
            ),
            body: SafeArea(
              child: CreateToDoEntryPageProvider(
                collectionId: state.extra as CollectionId,
              ),
            ),
          ),
    ),
    GoRoute(
      name: ToDoDetailPage.pageConfig.name,
      path: '$_basePath/${OverviewPage.pageConfig.name}/:collectionId',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('details'),
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name,
                    pathParameters: {'tab': OverviewPage.pageConfig.name},
                  );
                }
              },
            ),
          ),
          body: ToDoDetailPageProvider(
            collectionId: CollectionId.fromUniqueString(
              state.pathParameters['collectionId'] ?? '',
            ),
          ),
        );
      },
    ),
  ],
);
