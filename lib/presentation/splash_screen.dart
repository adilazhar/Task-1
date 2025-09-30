import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_1/controller/splash_screen_controller.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/presentation/home_screen.dart';
import 'package:task_1/presentation/login_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(splashScreenControllerProvider, (
      previous,
      next,
    ) {
      next.whenData((user) {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user.email),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            FlutterLogo(
              size: 100,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
