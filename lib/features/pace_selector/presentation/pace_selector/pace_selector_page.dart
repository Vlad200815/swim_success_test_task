import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/app/navigation.dart';
import 'package:swim_success_test_task/features/user_list/presentation/user_list/user_list_page.dart';

class PaceSelectorPage extends StatelessWidget {
  const PaceSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => UserListPage.open(context),
        child: Text("User List"),
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text("Pace Selector Page")),
    );
  }

  //
  // Navigation
  //
  static const String path = "/pace_selector";
  static const String name = "PaceSelector";

  static GoRoute route() {
    return Navigation.getRoute(name, path, (state) {
      return PaceSelectorPage();
    });
  }

  static Future<Object?> open(BuildContext context) {
    return context.push(Uri(path: path).toString());
  }
}
