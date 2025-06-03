import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/domain/entities/unique_id.dart';
import 'package:todo/presentation/core/go_router_observer.dart';
import 'package:todo/presentation/pages/dashboard/dashboard_page.dart';
import 'package:todo/presentation/pages/detail/todo_detail_page.dart';
import 'package:todo/presentation/pages/home/bloc/navigation_todo_cubit.dart';
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
      name: ToDoDetailPage.pageConfig.name,
      path: '$_basePath/${OverviewPage.pageConfig.name}/:collectionId',
      builder: (context, state) {
        return BlocListener<NavigationTodoCubit, NavigationToDoCubitState>(
          listenWhen:
              (previous, current) =>
                  previous.isSecondBodyDisplayed !=
                  current.isSecondBodyDisplayed,
          listener: (context, state) {
            if (context.canPop() && (state.isSecondBodyDisplayed ?? false)) {
              context.pop();
            }
          },
          child: Scaffold(
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
          ),
        );
      },
    ),
  ],
);
