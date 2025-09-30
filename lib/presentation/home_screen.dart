import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_1/controller/forms_controller.dart';
import 'package:task_1/presentation/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.email, {super.key});

  final String email;

  void logout(BuildContext context, WidgetRef ref) async {
    final isLoggedOut = await ref
        .read(formsControllerProvider.notifier)
        .logout();
    if (isLoggedOut) {
      log('User logged out successfully');
      if (context.mounted) {
        log('Navigating to LoginScreen');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          log('Post frame callback executed');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome\n$email', textAlign: TextAlign.center),
            ElevatedButton(
              onPressed: () => logout(context, ref),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
