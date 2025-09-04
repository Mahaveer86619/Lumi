import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumi/core/notifications/app_notifications.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
import 'package:lumi/features/auth/presentation/screens/auth_screen.dart';
import 'package:lumi/features/dashboard/presentation/screens/home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();

     // setup the notifications
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
    );


    context.read<AppUserCubit>().loadUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AppUserLoading) {
          log("Loading user...");
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppUserAuthenticated) {
          log("User is authenticated");
          return const HomeScreen();
        }

        log("User is not authenticated");
        return const AuthScreen();
      },
    );
  }
}