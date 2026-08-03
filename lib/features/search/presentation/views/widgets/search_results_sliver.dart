import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/core/widgets/animated_loading_widget.dart';
import 'package:ticketflow/core/widgets/empty_state_widget.dart';
import 'package:ticketflow/core/widgets/general_error_widget.dart';
import 'package:ticketflow/features/search/presentation/view_models/search_cubit/search_cubit.dart';
import 'package:ticketflow/features/search/presentation/view_models/search_cubit/search_state.dart';
import 'package:ticketflow/features/tickets/presentation/views/widgets/ticket_card.dart';

class SearchResultsSliver extends StatelessWidget {
  const SearchResultsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: AnimatedLoadingWidget(),
          );
        } else if (state is SearchFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: GeneralErrorWidget(
              message: state.errorMessage,
              onRetry: () => context.read<SearchCubit>().onQueryChanged(
                context.read<SearchCubit>().currentQuery,
              ),
            ),
          );
        } else if (state is SearchEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyStateWidget(
              title: 'No Tickets Found',
              subtitle: 'Try adjusting your search or filters.',
            ),
          );
        } else if (state is SearchInitial) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyStateWidget(
              title: 'Start Searching',
              subtitle: 'Type a subject or select a status to search tickets.',
            ),
          );
        } else if (state is SearchSuccess) {
          final tickets = context.read<SearchCubit>().searchResults;
          return SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TicketCard(ticket: tickets[index]),
                  );
                },
                childCount: tickets.length,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
