import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/widgets/cards/priority_chip.dart';
import 'package:ticketflow/core/widgets/cards/status_chip.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_cubit.dart';
import 'package:ticketflow/core/models/ticket_model.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';
import 'package:ticketflow/features/tickets/presentation/views/widgets/ticket_category_chip.dart';
import 'package:ticketflow/features/search/presentation/view_models/search_cubit/search_cubit.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () async {
        await push(context, Routes.ticketDetails, extra: ticket);
        if (context.mounted) {
          context.read<TicketCubit>().getAllTickets();
          context.read<DashboardCubit>().getDashboardStatistics();
          try {
            final searchCubit = context.read<SearchCubit>();
            searchCubit.onQueryChanged(searchCubit.currentQuery);
          } catch (_) {}
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),

          border: Border(
            left: BorderSide(color: ticket.category.color, width: 5),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(ticket: ticket),

              const SizedBox(height: 16),

              _Body(ticket: ticket),

              const SizedBox(height: 18),

              const Divider(color: AppColors.divider, height: 1),

              const SizedBox(height: 16),

              _Footer(ticket: ticket),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
//! Header
////////////////////////////////////////////////////////////////

class _Header extends StatelessWidget {
  const _Header({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ticket.ticketNumber,
          style: AppStyles.bold14.copyWith(
            color: ticket.category.color,
            letterSpacing: .3,
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            TicketCategoryChip(category: ticket.category),
            const SizedBox(width: 8),
            StatusChip(status: ticket.status),
          ],
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////
//! Body
////////////////////////////////////////////////////////////////

class _Body extends StatelessWidget {
  const _Body({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ticket.subject,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.bold16.copyWith(
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          ticket.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.regular14.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////
//! Footer
////////////////////////////////////////////////////////////////

class _Footer extends StatelessWidget {
  const _Footer({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PriorityChip(priority: ticket.priority),

        const Spacer(),

        const Icon(
          Icons.calendar_month_outlined,
          size: 16,
          color: AppColors.textMuted,
        ),

        const SizedBox(width: 6),

        Text(
          DateFormat('dd MMM yyyy, hh:mm a').format(ticket.createdAt),
          style: AppStyles.medium12.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
