import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/core/utils/assets/app_images.dart';
import 'package:ticketflow/core/utils/assets/app_lotties.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _animate = true);
    });

    // Navigate to HomeView after animation and some delay
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        pushReplacement(context, Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          AnimatedOpacity(
            opacity: _animate ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            child: AnimatedScale(
              scale: _animate ? 1.0 : 0.8,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              child: Center(
                child: Image.asset(AppImages.logoWithName, width: 200),
              ),
            ),
          ),
          const Spacer(),
          AnimatedSlide(
            offset: _animate ? Offset.zero : const Offset(0, 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: _animate ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              child: Lottie.asset(
                AppLotties.loadingJson,
                width: 120,
                height: 120,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
