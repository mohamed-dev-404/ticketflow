// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_cubit.dart';
import 'package:ticketflow/features/dashboard/presentation/views/dashboard_widget.dart';
import 'package:ticketflow/features/home/presentation/views/widgets/home_search_bar.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';
import 'package:ticketflow/features/tickets/presentation/views/tickets_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _onAddTicketPressed() async {
    await push(
      context,
      Routes.ticketForm,
      extra: {'isEdit': false, 'ticket': null},
    );
    // Refresh both dashboard and tickets list after returning
    if (context.mounted) {
      context.read<TicketCubit>().getAllTickets();
      context.read<DashboardCubit>().getDashboardStatistics();
    }
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      context.read<TicketCubit>().getAllTickets(),
      context.read<DashboardCubit>().getDashboardStatistics(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onAddTicketPressed,
        backgroundColor: AppColors.primary,
        elevation: 4,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'New Ticket',
          style: AppStyles.bold14.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          strokeWidth: 2.5,
          onRefresh: _onRefresh,
          child: const CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // 1. Dashboard
              DashboardWidget(),

              // 2. Search Field (Pinned)
              SliverAppBar(
                pinned: true,
                floating: false,
                backgroundColor: AppColors.background,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 84,
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: HomeSearchBar(),
                ),
              ),

              // 3. Tickets List
              TicketsList(),

              // 4. Bottom Padding
              SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
