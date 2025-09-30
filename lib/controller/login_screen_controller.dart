import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/repository/user_repository.dart';
import 'package:task_1/router/app_router.dart';

part 'login_screen_controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      log('Login Screen Controller Disposed');
    });
  }

  // Login
  Future<void> login(User user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 3));
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.setCurrentUser(user);
    });
    if (!state.hasError) {
      ref
          .read(appRouterProvider)
          .goNamed(AppRoute.home.name, queryParameters: {'email': user.email});
    }
  }
}
