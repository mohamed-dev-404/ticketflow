import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketflow/core/common/app_snack_bar.dart';
import 'package:ticketflow/core/enums/ticket_category.dart';
import 'package:ticketflow/core/enums/ticket_priority.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/utils/themes/app_shadows.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';
import 'package:ticketflow/core/validators/app_validators.dart';
import 'package:ticketflow/core/widgets/buttons/main_button.dart';
import 'package:ticketflow/core/widgets/inputs/app_text_form_field.dart';
import 'package:ticketflow/core/widgets/my_body_view.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/features/ticket_form/presentation/view_models/ticket_form_cubit/ticket_form_cubit.dart';
import 'package:ticketflow/features/ticket_form/presentation/view_models/ticket_form_cubit/ticket_form_state.dart';
import 'package:ticketflow/features/ticket_form/presentation/views/widgets/category_selector.dart';
import 'package:ticketflow/features/ticket_form/presentation/views/widgets/priority_selector.dart';
import 'package:ticketflow/features/ticket_form/presentation/views/widgets/status_selector.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

class TicketFormView extends StatefulWidget {
  final bool isEdit;
  final TicketModel? ticket;

  const TicketFormView({
    super.key,
    required this.isEdit,
    this.ticket,
  });

  @override
  State<TicketFormView> createState() => _TicketFormViewState();
}

class _TicketFormViewState extends State<TicketFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _subjectController;
  late final TextEditingController _descriptionController;

  TicketPriority _selectedPriority = TicketPriority.low;
  TicketCategory _selectedCategory = TicketCategory.technical;
  TicketStatus _selectedStatus = TicketStatus.open;
  TicketModel? _pendingUpdatedTicket;

  /// Used as a key for selectors to force rebuild on add-mode success reset.
  int _selectorResetKey = 0;

  bool get _isEdit => widget.isEdit;
  TicketModel? get _ticket => widget.ticket;

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(
      text: _isEdit ? _ticket?.subject ?? '' : '',
    );
    _descriptionController = TextEditingController(
      text: _isEdit ? _ticket?.description ?? '' : '',
    );

    if (_isEdit && _ticket != null) {
      _selectedPriority = _ticket!.priority;
      _selectedCategory = _ticket!.category;
      _selectedStatus = _ticket!.status;
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<TicketFormCubit>();

    if (_isEdit) {
      _pendingUpdatedTicket = _ticket!.copyWith(
        subject: _subjectController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _selectedPriority,
        category: _selectedCategory,
        status: _selectedStatus,
      );
      cubit.updateTicket(_pendingUpdatedTicket!);
    } else {
      cubit.addTicket(
        subject: _subjectController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _selectedPriority,
        category: _selectedCategory,
      );
    }
  }

  void _resetForm() {
    _subjectController.clear();
    _descriptionController.clear();
    _formKey.currentState?.reset();
    setState(() {
      _selectedPriority = TicketPriority.low;
      _selectedCategory = TicketCategory.technical;
      _selectorResetKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        toolbarHeight: 70,
        leading: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => pop(context),
          child: Container(
            margin: const EdgeInsets.all(12),
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
        title: Text(
          _isEdit ? 'Edit Ticket' : 'Create Support Ticket',
          style: AppStyles.bold16,
        ),
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocListener<TicketFormCubit, TicketFormState>(
        listener: (context, state) {
          if (state is TicketFormSuccess) {
            AppSnackBar.success(context, state.successMessage);
            if (!_isEdit) {
              _resetForm();
            } else {
              pop(context, _pendingUpdatedTicket);
            }
          } else if (state is TicketFormFailure) {
            AppSnackBar.error(context, state.errorMessage);
          }
        },
        child: MyBodyView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner (add mode only)
                  if (!_isEdit) ...[
                    _buildInfoBanner(),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  // Subject field
                  _buildSectionLabel('Subject', isRequired: true),
                  const SizedBox(height: AppSpacing.xs),
                  AppTextFormField(
                    controller: _subjectController,
                    hintText:
                        'Summarize your issue (e.g., VPN Authentication...)',
                    prefixIcon: const Icon(Icons.title),
                    textInputAction: TextInputAction.next,
                    validator: AppValidators.validateSubject,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Description field
                  _buildSectionLabel('Description', isRequired: true),
                  const SizedBox(height: AppSpacing.xs),
                  AppTextFormField(
                    controller: _descriptionController,
                    hintText:
                        'Provide complete details about the bug, error code, or issue you are experiencing...',
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: AppValidators.validateDescription,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Priority Level
                  _buildSectionLabel('Priority Level'),
                  const SizedBox(height: AppSpacing.xs),
                  PrioritySelector(
                    key: ValueKey('priority_$_selectorResetKey'),
                    initialPriority: _isEdit ? _ticket?.priority : null,
                    onPrioritySelected: (priority) {
                      _selectedPriority = priority;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Category
                  _buildSectionLabel('Category'),
                  const SizedBox(height: AppSpacing.xs),
                  CategorySelector(
                    key: ValueKey('category_$_selectorResetKey'),
                    initialCategory: _isEdit ? _ticket?.category : null,
                    onCategorySelected: (category) {
                      _selectedCategory = category;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Status (edit mode only)
                  if (_isEdit) ...[
                    _buildSectionLabel('Status'),
                    const SizedBox(height: AppSpacing.xs),
                    StatusSelector(
                      initialStatus: _ticket!.status,
                      onStatusSelected: (status) {
                        _selectedStatus = status;
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  const SizedBox(height: AppSpacing.md),

                  // Submit button
                  BlocBuilder<TicketFormCubit, TicketFormState>(
                    builder: (context, state) {
                      return MainButton(
                        text: _isEdit ? 'Update Ticket' : 'Create Ticket',
                        isLoading: state is TicketFormLoading,
                        onPressed: _onSubmit,
                        minHeight: 52,
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: AppStyles.medium14.copyWith(color: AppColors.textPrimary),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: AppStyles.medium14.copyWith(color: AppColors.error),
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Automatic Generation',
                  style: AppStyles.bold14.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'Ticket ID, Creation Timestamp, and initial Status (Open) will be automatically assigned upon creation.',
                  style: AppStyles.regular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
