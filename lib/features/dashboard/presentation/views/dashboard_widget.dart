import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/utils/themes/app_radius.dart';
import 'package:ticketflow/core/utils/themes/app_shadows.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/core/widgets/animated_loading_widget.dart';
import 'package:ticketflow/core/widgets/general_error_widget.dart';
import 'package:ticketflow/features/dashboard/data/models/ticket_statistics_model.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_cubit.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_state.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardInitial || state is DashboardLoading) {
              return const _DashboardCard(
                child: SizedBox(
                  height: 200,
                  child: AnimatedLoadingWidget(height: 100),
                ),
              );
            } else if (state is DashboardFailure) {
              return _DashboardCard(
                child: SizedBox(
                  height: 200,
                  child: GeneralErrorWidget(
                    message: state.errorMessage,
                    onRetry: () =>
                        context.read<DashboardCubit>().getDashboardStatistics(),
                  ),
                ),
              );
            }

            final statistics = context.read<DashboardCubit>().statistics;
            return _DashboardCard(
              child: _DashboardContent(statistics: statistics),
            );
          },
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Card wrapper
// ──────────────────────────────────────────────────────────────

class _DashboardCard extends StatelessWidget {
  final Widget child;

  const _DashboardCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderXl,
        boxShadow: AppShadows.md,
      ),
      child: child,
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Dashboard Content (chart + legend + total)
// ──────────────────────────────────────────────────────────────

class _DashboardContent extends StatelessWidget {
  final TicketStatisticsModel statistics;

  const _DashboardContent({required this.statistics});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = statistics.totalTickets == 0;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: const BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: AppRadius.borderMd,
                ),
                child: const Icon(
                  Icons.dashboard_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Dashboard',
                style: AppStyles.bold16.copyWith(color: AppColors.textPrimary),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: AppRadius.borderPill,
                ),
                child: Text(
                  '${statistics.totalTickets} Total',
                  style: AppStyles.bold14.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Chart + Legend
          if (isEmpty)
            _buildEmptyState()
          else
            Row(
              children: [
                // Pie Chart with total in center
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: 45,
                            sections: _buildSections(),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                        // Total in center
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${statistics.totalTickets}',
                              style: AppStyles.bold24.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'Total',
                              style: AppStyles.medium12.copyWith(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                // Legend
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LegendItem(
                        color: TicketStatus.open.color,
                        label: 'Open',
                        count: statistics.openTickets,
                        total: statistics.totalTickets,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _LegendItem(
                        color: TicketStatus.inProgress.color,
                        label: 'In Progress',
                        count: statistics.inProgressTickets,
                        total: statistics.totalTickets,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _LegendItem(
                        color: TicketStatus.closed.color,
                        label: 'Closed',
                        count: statistics.closedTickets,
                        total: statistics.totalTickets,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 120,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.pie_chart_outline_rounded,
              size: 40,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'No tickets yet',
              style: AppStyles.medium14.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    final total = statistics.totalTickets;

    return [
      PieChartSectionData(
        value: statistics.openTickets.toDouble(),
        color: TicketStatus.open.color,
        radius: 44,
        title: '${_percentage(statistics.openTickets, total)}%',
        titleStyle: AppStyles.bold12.copyWith(color: Colors.white),
        titlePositionPercentageOffset: 0.5,
      ),
      PieChartSectionData(
        value: statistics.inProgressTickets.toDouble(),
        color: TicketStatus.inProgress.color,
        radius: 34,
        title: '${_percentage(statistics.inProgressTickets, total)}%',
        titleStyle: AppStyles.bold12.copyWith(
          fontSize: 11,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.45,
      ),
      PieChartSectionData(
        value: statistics.closedTickets.toDouble(),
        color: TicketStatus.closed.color,
        radius: 34,
        title: '${_percentage(statistics.closedTickets, total)}%',
        titleStyle: AppStyles.bold12.copyWith(
          fontSize: 11,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.45,
      ),
    ];
  }

  int _percentage(int count, int total) {
    if (total == 0) return 0;
    return ((count / total) * 100).round();
  }
}

// ──────────────────────────────────────────────────────────────
// Legend Item
// ──────────────────────────────────────────────────────────────

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int count;
  final int total;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.count,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: AppStyles.medium12.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Text(
          '$count',
          style: AppStyles.bold14.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
