import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_category.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/core/widgets/cards/category_chip.dart';

class CategorySelector extends StatefulWidget {
  final TicketCategory? initialCategory;
  final ValueChanged<TicketCategory> onCategorySelected;

  const CategorySelector({
    super.key,
    this.initialCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  late TicketCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? TicketCategory.technical;

    // Notify parent of initial value right after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCategorySelected(_selectedCategory);
    });
  }

  void _handleTap(TicketCategory category) {
    if (_selectedCategory != category) {
      setState(() {
        _selectedCategory = category;
      });
      widget.onCategorySelected(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TicketCategory.values.map((category) {
        final isSelected = _selectedCategory == category;
        final isLast = category == TicketCategory.values.last;

        return Padding(
          padding: EdgeInsets.only(right: isLast ? 0 : AppSpacing.xs),
          child: InkWell(
            onTap: () => _handleTap(category),
            borderRadius: BorderRadius.circular(999),
            child: CategoryChip(
              category: category,
              isSelected: isSelected,
            ),
          ),
        );
      }).toList(),
    );
  }
}
