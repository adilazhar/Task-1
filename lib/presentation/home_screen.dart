import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_1/controller/home_screen_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.email, {super.key});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(homeScreenControllerProvider).isLoading;
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome\n$email', textAlign: TextAlign.center),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async => await ref
                        .read(homeScreenControllerProvider.notifier)
                        .logout(),
              child: isLoading ? CircularProgressIndicator() : Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
