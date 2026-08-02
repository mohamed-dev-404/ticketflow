import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/widgets/animated_loading_widget.dart';
import 'package:ticketflow/core/widgets/empty_state_widget.dart';
import 'package:ticketflow/core/widgets/general_error_widget.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_state.dart';
import 'package:ticketflow/features/tickets/presentation/views/widgets/ticket_card.dart';

class TicketsList extends StatelessWidget {
  const TicketsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      builder: (context, state) {
        if (state is TicketInitial || state is TicketLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: AnimatedLoadingWidget(),
          );
        } else if (state is TicketFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: GeneralErrorWidget(
              message: state.errorMessage,
              onRetry: () => context.read<TicketCubit>().getAllTickets(),
            ),
          );
        }

        final tickets = context.read<TicketCubit>().tickets;

        if (state is TicketSuccess && tickets.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyStateWidget(
              title: 'No Tickets Found',
              subtitle: 'There are currently no tickets to display.',
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final ticket = tickets[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TicketCard(ticket: ticket),
                );
              },
              childCount: tickets.length,
            ),
          ),
        );
      },
    );
  }
}
