import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocabulary_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_vocabulary_app/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() =>
        BlocProvider.of<AuthBloc>(context).add(const SignOutEvent());

    return Stack(
      children: [
        /// #main ui
        Scaffold(
          appBar: AppBar(
            title: const Text('Profile Page'),
            actions: [
              /// #sign out button
              IconButton(
                onPressed: signOut,
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.primaries[Random().nextInt(18)],
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Text(
                        AuthService.currentUser.displayName![0],
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Text(AuthService.currentUser.displayName!);
                  },
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Text(AuthService.currentUser.email!);
                  },
                ),
              ],
            ),
          ),
        ),

        /// #loading
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
