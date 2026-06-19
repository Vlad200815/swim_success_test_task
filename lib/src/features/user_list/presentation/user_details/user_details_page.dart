import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/src/app/navigation.dart';
import 'package:swim_success_test_task/src/core/extension/extensions.dart';

class UserDetailsPage extends StatelessWidget {
  final String userId;
  final String section;

  const UserDetailsPage({
    super.key,
    required this.userId,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("User Details Page")));
  }

  //
  // Navigation
  //
  static const String path = "/user_details/:$paramId";
  static const String name = "UserDetails";
  static const String paramId = "param_id";

  static GoRoute route() {
    return Navigation.getRoute(name, path, (state) {
      final String productId = state.pathParameters[paramId].orEmpty();
      final String section = state.extra as String;

      return UserDetailsPage(userId: productId, section: section);
    });
  }

  static Future<Object?> open(
    BuildContext context, {
    required String id,
    required String section,
  }) {
    return context.pushNamed(
      name,
      pathParameters: {paramId: id},
      extra: section,
    );
  }
}
