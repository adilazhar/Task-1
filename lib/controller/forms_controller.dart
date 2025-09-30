import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/repository/user_repository.dart';

part 'forms_controller.g.dart';

@Riverpod(keepAlive: true)
class FormsController extends _$FormsController {
  @override
  FutureOr<void> build() {}

  // signup
  Future<bool> signUp(User user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.saveUser(user);
    });
    return !state.hasError;
  }

  // logout
  Future<bool> logout() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.deleteUser();
    });
    return !state.hasError;
  }
}
