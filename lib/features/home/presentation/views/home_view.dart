import 'package:flutter/material.dart';

import 'package:ticketflow/core/utils/colors/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicketFlow'),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child:  Text(
          'Welcome to TicketFlow!',
        ),
      ),
    );
  }
}
