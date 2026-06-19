import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/src/app/navigation.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/user_details/user_details_page.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserDetailsPage.open(context, id: 'test', section: 'test');
        },
        child: Text("User Details"),
      ),
      body: const Center(child: Text("User List Page")),
    );
  }

  //
  // Navigation
  //
  static const String path = "/user_list";
  static const String name = "UserList";

  static GoRoute route() {
    return Navigation.getRoute(name, path, (state) {
      return UserListPage();
    });
  }

  static Future<Object?> open(BuildContext context) {
    return context.push(Uri(path: path).toString());
  }
}
