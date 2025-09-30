import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/repository/user_repository.dart';
import 'package:task_1/router/app_router.dart';

part 'home_screen_controller.g.dart';

@riverpod
class HomeScreenController extends _$HomeScreenController {
  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      log('Home Screen Controller Disposed');
    });
  }

  Future<void> logout() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 3));
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.clearCurrentUser();
    });
    if (!state.hasError) {
      ref.read(appRouterProvider).goNamed(AppRoute.login.name);
    }
  }
}
