import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/repository/user_repository.dart';

part 'splash_screen_controller.g.dart';

@riverpod
FutureOr<User?> splashScreenController(Ref ref) async {
  await Future.delayed(const Duration(seconds: 3));
  final repo = ref.watch(userRepositoryProvider);
  final user = await repo.getUser();
  return user;
}
