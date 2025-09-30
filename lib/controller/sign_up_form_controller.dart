import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/repository/user_repository.dart';

part 'sign_up_form_controller.g.dart';

@Riverpod(keepAlive: true)
class SignUpFormController extends _$SignUpFormController {
  @override
  FutureOr<void> build() {}

  // signup
  Future<bool> signUp(User user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userRepository = ref.read(userRepositoryProvider);
      await userRepository.addUser(user);
    });
    return !state.hasError;
  }
}
