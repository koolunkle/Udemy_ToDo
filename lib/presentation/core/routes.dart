import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/presentation/core/go_router_observer.dart';
import 'package:todo/presentation/pages/dashboard/dashboard_page.dart';
import 'package:todo/presentation/pages/home/home_page.dart';
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
  ],
);
