import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/repository/user_repository.dart';

part 'forms_controller.g.dart';

@riverpod
class FormsController extends _$FormsController {
  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      log('Form Controller Disposed');
    });
  }

  // signup
  Future<bool> signUp(User user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.addUser(user);
    });
    return !state.hasError;
  }

  // logout
  Future<bool> logout() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.clearCurrentUser();
    });
    return !state.hasError;
  }

  // Login
  Future<bool> login(User user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.setCurrentUser(user);
    });
    return !state.hasError;
  }

  // Delete Account
  Future<bool> deleteAccount(String email) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.deleteUser(email);
    });
    return !state.hasError;
  }
}
