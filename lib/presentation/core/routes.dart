import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/presentation/core/go_router_observer.dart';
import 'package:todo/presentation/pages/home/home_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) {
        return Container(
          color: Colors.amber,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => context.push('/home/start'),
                child: Text('Go to start'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/start');
                  }
                },
                child: Text('Go back'),
              ),
            ],
          ),
        );
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return HomePage();
      },
    ),
  ],
);
