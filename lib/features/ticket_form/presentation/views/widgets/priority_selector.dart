import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_priority.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/themes/app_radius.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/core/widgets/cards/priority_chip.dart';

class PrioritySelector extends StatefulWidget {
  final TicketPriority? initialPriority;
  final ValueChanged<TicketPriority> onPrioritySelected;

  const PrioritySelector({
    super.key,
    this.initialPriority,
    required this.onPrioritySelected,
  });

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  late TicketPriority _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.initialPriority ?? TicketPriority.low;

    // Notify parent of initial value right after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPrioritySelected(_selectedPriority);
    });
  }

  void _handleTap(TicketPriority priority) {
    if (_selectedPriority != priority) {
      setState(() {
        _selectedPriority = priority;
      });
      widget.onPrioritySelected(priority);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TicketPriority.values.map((priority) {
        final isSelected = _selectedPriority == priority;
        final isLast = priority == TicketPriority.values.last;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : AppSpacing.xs),
            child: InkWell(
              onTap: () => _handleTap(priority),
              borderRadius: AppRadius.borderMd,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected
                      ? priority.color.withValues(alpha: 0.15)
                      : AppColors.slate100,
                  borderRadius: AppRadius.borderMd,
                  border: Border.all(
                    color: isSelected ? priority.color : AppColors.slate200,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                child: Center(
                  child: PriorityChip(
                    priority: priority,
                    compact: true,
                    showDecoration: false,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
