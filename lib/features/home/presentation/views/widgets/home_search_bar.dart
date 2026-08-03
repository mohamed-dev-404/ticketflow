import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/utils/assets/app_images.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/utils/themes/app_shadows.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_cubit.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: AppShadows.sm,
          ),
          child: Image.asset(
            AppImages.iconLogo,
            height: 28,
            width: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Hero(
            tag: 'search_bar',
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppShadows.md,
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () async {
                    await push(context, Routes.search);
                    if (context.mounted) {
                      context.read<TicketCubit>().getAllTickets();
                      context.read<DashboardCubit>().getDashboardStatistics();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Find a ticket by subject...',
                            style: AppStyles.medium14.copyWith(
                              color: AppColors.slate400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
