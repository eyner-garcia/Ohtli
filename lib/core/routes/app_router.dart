import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/utils/presentation/views/gatekeeper_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/verify_otp_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/home/presentation/views/swipe_screen.dart';
import '../../features/utils/presentation/views/onboarding_view.dart';
import '../../features/utils/presentation/views/splash_view.dart';

part 'app_router.g.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(
      authViewModelProvider,
          (_, __) => notifyListeners(),
    );
  }
}

@Riverpod(keepAlive: true)
RouterNotifier routerNotifier(RouterNotifierRef ref) {
  return RouterNotifier(ref);
}

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authViewModelProvider);
      final isAuthenticated = authState.asData?.value != null;

      final publicRoutes = [
        '/splash',
        '/onboarding',
        '/gatekeeper',
        '/login',
        '/register',
        '/forgot-password',
        '/verify-otp',
        '/reset-password'
      ];
      final isPublicRoute = publicRoutes.contains(state.matchedLocation);

      if (!isAuthenticated && !isPublicRoute) {
        return '/gatekeeper';
      }

      if (isAuthenticated && isPublicRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/gatekeeper',
        builder: (context, state) => const GatekeeperView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return VerifyOtpView(email: email);
        },
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ohtli - Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authViewModelProvider.notifier).logout(),
          ),
        ],
      ),
      body: const Center(child: Text('¡Bienvenido a tu próxima Aventura!')),
    );
  }
}