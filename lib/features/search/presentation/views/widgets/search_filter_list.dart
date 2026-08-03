import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/features/search/presentation/view_models/search_cubit/search_cubit.dart';
import 'package:ticketflow/features/search/presentation/views/widgets/ticket_status_filter_chip.dart';

class SearchFilterList extends StatelessWidget {
  const SearchFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    final statuses = [
      null,
      TicketStatus.open,
      TicketStatus.inProgress,
      TicketStatus.closed,
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: statuses.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = statuses[index];
          final selectedStatus = context.watch<SearchCubit>().selectedStatus;

          return TicketStatusFilterChip(
            status: status,
            selected: selectedStatus == status,
            onTap: () {
              context.read<SearchCubit>().onStatusChanged(status);
            },
          );
        },
      ),
    );
  }
}
