import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/repository/user_repository.dart';
import 'package:task_1/router/app_router.dart';

part 'sign_up_screen_controller.g.dart';

@riverpod
class SignUpScreenController extends _$SignUpScreenController {
  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      log('Sign Up Screen Controller Disposed');
    });
  }

  // signup
  Future<void> signUp(User user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 3));
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.addUser(user);
    });
    if (!state.hasError) {
      ref
          .read(appRouterProvider)
          .goNamed(
            AppRoute.login.name,
            queryParameters: {
              'accountCreated': 'true',
            },
          );
    }
  }

  // logout
  // Future<bool> logout() async {
  //   state = AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final userRepository = ref.read(userRepositoryProvider);
  //     await userRepository.clearCurrentUser();
  //   });
  //   return !state.hasError;
  // }

  // Delete Account
  // Future<bool> deleteAccount(String email) async {
  //   state = AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final userRepository = ref.read(userRepositoryProvider);
  //     await userRepository.deleteUser(email);
  //   });
  //   return !state.hasError;
  // }
}
