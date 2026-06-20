import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_success_test_task/src/app/navigation.dart';
import 'package:swim_success_test_task/src/core/di/di.dart';
import 'package:swim_success_test_task/src/core/extension/extensions.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/user_details/widgets/widgets.dart';
import 'package:swim_success_test_task/src/features/user_list/presentation/widgets/custom_label.dart';

import 'cubit/user_details_cubit.dart';

class UserDetailsPage extends StatelessWidget {
  final int userId;

  const UserDetailsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, state) {
        if (state is UserDetailsLoadingState) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(title: const Text('Loading...'), centerTitle: true),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is UserDetailsFailureState) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(title: const Text('Error'), centerTitle: true),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try Again'),
                      onPressed: () {
                        context.read<UserDetailsCubit>().fetchUserById(
                          userId: userId,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is UserDetailsSuccessState) {
          final user = state.user;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(user.username ?? 'Profile'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Top profile header card
                        UserHeaderSection(
                          name: user.name.orEmpty(),
                          username: user.username.orEmpty(),
                        ),
                        const SizedBox(height: 16),

                        // Contact details card
                        DetailCardGroup(
                          title: 'CONTACT INFO',
                          children: [
                            DetailRow(
                              icon: Icons.email_outlined,
                              label: 'Email',
                              value: user.email,
                            ),
                            DetailRow(
                              icon: Icons.phone_outlined,
                              label: 'Phone',
                              value: user.phone,
                            ),
                            DetailRow(
                              icon: Icons.language_outlined,
                              label: 'Website',
                              value: user.website,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        if (user.address != null)
                          DetailCardGroup(
                            title: 'ADDRESS',
                            children: [
                              DetailRow(
                                icon: Icons.location_on_outlined,
                                label: 'Street',
                                value:
                                    '${user.address!.suite}, ${user.address!.street}',
                              ),
                              DetailRow(
                                icon: Icons.location_city_outlined,
                                label: 'City',
                                value: user.address!.city,
                              ),
                              DetailRow(
                                icon: Icons.markunread_mailbox_outlined,
                                label: 'Zipcode',
                                value: user.address!.zipcode,
                              ),
                              if (user.address!.geo != null)
                                DetailRow(
                                  icon: Icons.map_outlined,
                                  label: 'Coordinates',
                                  value:
                                      'Lat: ${user.address!.geo!.lat}, Lng: ${user.address!.geo!.lng}',
                                ),
                            ],
                          ),
                        const SizedBox(height: 16),

                        if (user.company != null)
                          DetailCardGroup(
                            title: 'COMPANY',
                            children: [
                              DetailRow(
                                icon: Icons.business_center_outlined,
                                label: 'Name',
                                value: user.company!.name,
                              ),
                              DetailRow(
                                icon: Icons.bolt_outlined,
                                label: 'Catch Phrase',
                                value: user.company!.catchPhrase,
                              ),
                              DetailRow(
                                icon: Icons.layers_outlined,
                                label: 'BS',
                                value: user.company!.bs,
                              ),
                            ],
                          ),
                        CustomLabel(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Fallback default state
        return const Scaffold(
          body: Center(child: Text('No data initialization active.')),
        );
      },
    );
  }

  //
  // Navigation
  //
  static const String path = "/user_details/:$paramId";
  static const String name = "UserDetails";
  static const String paramId = "param_id";

  static GoRoute route() {
    return Navigation.getRoute(name, path, (state) {
      final String userId = state.pathParameters[paramId].orEmpty();

      return BlocProvider(
        create: (context) =>
            UserDetailsCubit(fetchUserByIdUseCase: di.get())
              ..fetchUserById(userId: userId.toNumber()),
        child: UserDetailsPage(userId: userId.toNumber()),
      );
    });
  }

  static Future<Object?> open(BuildContext context, {required String id}) {
    return context.pushNamed(name, pathParameters: {paramId: id});
  }
}
