import 'package:flutter/material.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/features/search/presentation/views/widgets/search_filter_list.dart';
import 'package:ticketflow/features/search/presentation/views/widgets/search_input_bar.dart';
import 'package:ticketflow/features/search/presentation/views/widgets/search_results_sliver.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: SearchInputBar(),
              ),
            ),
            SliverToBoxAdapter(
              child: SearchFilterList(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            SearchResultsSliver(),
          ],
        ),
      ),
    );
  }
}
