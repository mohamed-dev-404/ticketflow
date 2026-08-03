import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/utils/themes/app_shadows.dart';
import 'package:ticketflow/features/search/presentation/view_models/search_cubit/search_cubit.dart';

class SearchInputBar extends StatefulWidget {
  const SearchInputBar({super.key});

  @override
  State<SearchInputBar> createState() => _SearchInputBarState();
}

class _SearchInputBarState extends State<SearchInputBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<SearchCubit>().currentQuery,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back Button
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => pop(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: AppShadows.sm,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Search Field
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
                child: TextField(
                  controller: _controller,
                  onChanged: (value) =>
                      context.read<SearchCubit>().onQueryChanged(value),
                  style: AppStyles.medium14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Find a ticket by subject...',
                    hintStyle: AppStyles.medium14.copyWith(
                      color: AppColors.slate400,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Sort Button
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.read<SearchCubit>().toggleSortOrder(),
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppShadows.sm,
            ),
            child: const Icon(
              Icons.swap_vert_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
