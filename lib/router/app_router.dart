import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/presentation/home_screen.dart';
import 'package:task_1/presentation/login_screen.dart';
import 'package:task_1/presentation/signup_screen.dart';
import 'package:task_1/presentation/splash_screen.dart';

part 'app_router.g.dart';

enum AppRoute {
  splash,
  home,
  login,
  signup,
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? 'Guest';
          return HomeScreen(email);
        },
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) {
          final accountCreated =
              state.uri.queryParameters['accountCreated'] == 'true';
          return LoginScreen(accountCreated: accountCreated);
        },
      ),
      GoRoute(
        path: '/signup',
        name: AppRoute.signup.name,
        builder: (context, state) => const SignupScreen(),
      ),
    ],
  );
}
