import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/themes/app_radius.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/core/widgets/cards/status_chip.dart';

class StatusSelector extends StatefulWidget {
  final TicketStatus initialStatus;
  final ValueChanged<TicketStatus> onStatusSelected;

  const StatusSelector({
    super.key,
    required this.initialStatus,
    required this.onStatusSelected,
  });

  @override
  State<StatusSelector> createState() => _StatusSelectorState();
}

class _StatusSelectorState extends State<StatusSelector> {
  late TicketStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;

    // Notify parent of initial value right after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStatusSelected(_selectedStatus);
    });
  }

  void _handleTap(TicketStatus status) {
    if (_selectedStatus != status) {
      setState(() {
        _selectedStatus = status;
      });
      widget.onStatusSelected(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TicketStatus.values.map((status) {
        final isSelected = _selectedStatus == status;
        final isLast = status == TicketStatus.values.last;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : AppSpacing.xs),
            child: InkWell(
              onTap: () => _handleTap(status),
              borderRadius: AppRadius.borderMd,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected
                      ? status.color.withValues(alpha: 0.15)
                      : AppColors.slate100,
                  borderRadius: AppRadius.borderMd,
                  border: Border.all(
                    color: isSelected ? status.color : AppColors.slate200,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                child: Center(
                  child: StatusChip(
                    status: status,
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
