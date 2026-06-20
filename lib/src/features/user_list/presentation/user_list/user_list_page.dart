import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/src/app/navigation.dart';
import 'package:swim_success_test_task/src/core/di/di.dart';
import 'package:swim_success_test_task/src/core/extension/extensions.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/widgets/custom_lable.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/widgets/user_card.dart';

import 'bloc/user_list_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users'), centerTitle: true),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListSuccessState) {
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  final bloc = context.read<UserListBloc>();
                  bloc.add(FetchAllUserEvent(isRefresh: true));

                  await bloc.stream.firstWhere(
                    (state) => state is! UserListLoadingState,
                  );
                },

                child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserCard(
                          name: user.name.orEmpty(),
                          email: user.email.orEmpty(),
                          phone: user.phone.orEmpty(),
                        );
                      },
                    ),
                    SliverToBoxAdapter(child: CustomLable()),
                  ],
                ),
              ),
            );
          } else if (state is UserListFailureState) {
            return RefreshIndicator(
              onRefresh: () async => context.read<UserListBloc>().add(
                FetchAllUserEvent(isRefresh: true),
              ),

              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                  Center(child: Text('Error: ${state.message}')),
                ],
              ),
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  //
  // Navigation
  //
  static const String path = "/user_list";
  static const String name = "UserList";

  static GoRoute route() {
    return Navigation.getRoute(name, path, (state) {
      return BlocProvider(
        create: (context) =>
            UserListBloc(fetchAllUsersUseCase: di.get())
              ..add(FetchAllUserEvent()),
        child: UserListPage(),
      );
    });
  }

  static Future<Object?> open(BuildContext context) {
    return context.push(Uri(path: path).toString());
  }
}
