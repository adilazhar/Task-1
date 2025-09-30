import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/repository/user_repository.dart';
import 'package:task_1/router/app_router.dart';

part 'splash_screen_controller.g.dart';

@riverpod
FutureOr<void> splashScreenController(Ref ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final repo = ref.watch(userRepositoryProvider);
  final user = await repo.getCurrentUser();
  log('Current User: $user');
  final approuter = ref.read(appRouterProvider);
  if (user != null) {
    approuter.goNamed(
      AppRoute.home.name,
      queryParameters: {'email': user.email},
    );
  } else {
    approuter.goNamed(AppRoute.login.name);
  }
}
