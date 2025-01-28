import 'package:aider_mobile_app/core/routing/app_navigator.dart';
import 'package:aider_mobile_app/core/routing/app_route.dart';
import 'package:aider_mobile_app/core/constants/common.dart';
import 'package:aider_mobile_app/core/utils/app_theme_util.dart';
import 'package:aider_mobile_app/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      _controller.forward();
      await Future.delayed(const Duration(milliseconds: 2500));
      if (!mounted) return;

      if (await context.read<AuthProvider>().isLoggedIn()) {
        if (!mounted) return;
        await fetchPersistedLocalData();

        if (!mounted) return;
        AppNavigator.pushReplacementNamed(context, AppRoute.homeScreen);
        return;
      }

      if (!mounted) return;
      AppNavigator.pushReplacementNamed(context, AppRoute.onboardingScreen);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF680F3D),
        body: ScaleTransition(
          scale: _animation,
          child: Center(
            child: Image.asset(
              '$kImagePath/logo.png',
              width: AppThemeUtil.width(228.0),
              height: AppThemeUtil.height(56.0),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchPersistedLocalData() async {
    // FETCH DATA IN PERSISTED LOCAL DATABASES
    await context.read<UserProvider>().initState();
  }
}
