import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ticketflow/core/utils/assets/app_lotties.dart';

class AnimatedLoadingWidget extends StatelessWidget {
  final double height;

  const AnimatedLoadingWidget({super.key, this.height = 150});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppLotties.loadingJson, height: height));
  }
}
