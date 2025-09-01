import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumi/core/user/cubit/app_user_cubit.dart';
import 'package:lumi/features/auth/presentation/bloc/auth_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  void _changeScreen(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool isReplacement = false,
  }) {
    if (isReplacement) {
      Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void checkLogin() {
    _showMessage('Login button pressed');
  }

  void checkRegister() {
    _showMessage('Register button pressed');
    context.read<AuthBloc>().add(SignUpEvent(
      fullName: 'Test User 2',
      email: 'test2@example.com',
      password: 'password123',
    ));
  }

  void checkRefreshTokens() {
    _showMessage('Refresh Tokens button pressed');
  }

  @override
  void initState() {
    super.initState();

    context.read<AppUserCubit>().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLogin(),
    );
  }

  Widget buildLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: checkLogin,
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: checkRegister,
          child: const Text('Register'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: checkRefreshTokens,
          child: const Text('Refresh Tokens'),
        ),
        const SizedBox(height: 40),
        const Text(
          'User Information:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        buildUserInfo(),
      ],
    );
  }

  Widget buildUserInfo() {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AppUserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppUserAuthenticated) {
          final user = state.user;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ID: ${user.id}'),
              Text('Name: ${user.fullName}'),
              Text('Email: ${user.email}'),
              Text('Auth Type: ${user.authType}'),
              if (user.profilePicture.isNotEmpty)
                Image.network(user.profilePicture),
            ],
          );
        } else if (state is AppUserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No user data'));
        }
      },
    );
  }
}
