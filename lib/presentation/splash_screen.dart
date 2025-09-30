import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_1/controller/splash_screen_controller.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('Splash Screen Built');
    final state = ref.watch(splashScreenControllerProvider);
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
