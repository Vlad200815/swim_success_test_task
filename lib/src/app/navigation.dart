import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/src/features/pace_selector/presentation/pace_selector/pace_selector_page.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/user_details/user_details_page.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/user_list/user_list_page.dart';

class Navigation {
  ///
  /// Global navigation config
  ///

  static GoRouter? _instance;

  static GoRouter router() {
    if (_instance != null) return _instance!;
    _instance = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: PaceSelectorPage.path,

      errorBuilder: (context, state) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      routes: [
        // Pace Selector
        PaceSelectorPage.route(),

        // User List
        UserListPage.route(),

        // User Details
        UserDetailsPage.route(),
      ],
    );
    return _instance!;
  }

  ///
  /// Create default route with config
  ///

  static GoRoute getRoute(
    String name,
    String path,

    final Widget Function(GoRouterState state) callback, {
    GlobalKey<NavigatorState>? navKey,
    final Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    )?
    transitionBuilder,
  }) {
    return GoRoute(
      parentNavigatorKey: navKey,
      name: name,
      path: path,
      pageBuilder: (context, state) {
        if (transitionBuilder != null) {
          return CustomTransitionPage(
            child: callback(state),
            transitionsBuilder: transitionBuilder,
          );
        }

        if (Platform.isIOS) {
          return CupertinoPage(child: callback(state));
        } else {
          return MaterialPage(child: callback(state));
        }
      },
    );
  }
}
