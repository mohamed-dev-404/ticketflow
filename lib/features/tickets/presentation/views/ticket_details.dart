import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticketflow/core/common/app_dialogs.dart';
import 'package:ticketflow/core/common/app_snack_bar.dart';
import 'package:ticketflow/core/routes/navigations_helper.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/utils/themes/app_shadows.dart';
import 'package:ticketflow/core/widgets/cards/priority_chip.dart';
import 'package:ticketflow/core/widgets/cards/status_chip.dart';
import 'package:ticketflow/core/models/ticket_model.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_state.dart';
import 'package:ticketflow/features/tickets/presentation/views/widgets/ticket_category_chip.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  late TicketModel _ticket;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _ticket = widget.ticket;
  }

  Future<void> _onEditTicket() async {
    final updatedTicket = await push<TicketModel>(
      context,
      Routes.ticketForm,
      extra: {
        'isEdit': true,
        'ticket': _ticket,
      },
    );

    if (updatedTicket != null && mounted) {
      setState(() {
        _ticket = updatedTicket;
      });
    }
  }

  void _onDeleteTicket() {
    AppDialogs.showAlertDialog(
      context,
      title: 'Delete Ticket',
      subtitle: 'Are you sure to delete ticket number ${_ticket.ticketNumber}?',
      icon: Icons.delete_outline_rounded,
      iconColor: AppColors.error,
      okButtonColor: AppColors.error,
      ok: 'Delete',
      no: 'Cancel',
      onTap: () {
        pop(context);
        _isDeleting = true;
        AppDialogs.showLoadingDialog(context);
        context.read<TicketCubit>().deleteTicketById(_ticket.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketCubit, TicketState>(
      listener: (context, state) {
        if (_isDeleting) {
          if (state is TicketSuccess) {
            _isDeleting = false;
            pop(context); // dismiss loading dialog
            pop(context); // pop details screen back to home
            AppSnackBar.success(context, 'Ticket deleted successfully');
          } else if (state is TicketFailure) {
            _isDeleting = false;
            pop(context); // dismiss loading dialog
            AppSnackBar.error(context, state.errorMessage);
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(ticket: _ticket),

              const SizedBox(height: 28),

              _InformationSection(ticket: _ticket),

              const SizedBox(height: 28),

              _DescriptionSection(ticket: _ticket),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
      title: const Text('Ticket Details'),
      centerTitle: true,
      backgroundColor: AppColors.background,
      actions: [
        IconButton(
          onPressed: _onEditTicket,
          icon: const Icon(color: AppColors.primary, Icons.edit_outlined),
        ),
        IconButton(
          onPressed: _onDeleteTicket,
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: AppColors.error,
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////
/// Header
///////////////////////////////////////////////////////////////

class _Header extends StatelessWidget {
  const _Header({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(color: ticket.category.color, width: 6),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusChip(status: ticket.status),

          const SizedBox(height: 18),

          Text(
            ticket.ticketNumber,
            style: AppStyles.bold20.copyWith(color: ticket.category.color),
          ),

          const SizedBox(height: 10),

          Text(
            ticket.subject,
            style: AppStyles.bold24.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
///////////////////////////////////////////////////////////////
/// Information Section
///////////////////////////////////////////////////////////////

class _InformationSection extends StatelessWidget {
  const _InformationSection({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(color: ticket.category.color, width: 6),
        ),
      ),
      child: Column(
        children: [
          Column(
            children: [
              _InfoCard(
                title: 'Category',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TicketCategoryChip(category: ticket.category),
                ),
              ),

              const SizedBox(height: 12),

              const Divider(),

              const SizedBox(height: 12),

              _InfoCard(
                title: 'Priority',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PriorityChip(priority: ticket.priority),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Divider(),

          const SizedBox(height: 20),

          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Created At',
                      style: AppStyles.bold16.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      DateFormat(
                        'dd MMM yyyy • hh:mm a',
                      ).format(ticket.createdAt),
                      style: AppStyles.medium14.copyWith(
                        color: AppColors.textPrimary,
                      ),
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
}

///////////////////////////////////////////////////////////////
/// Info Card
///////////////////////////////////////////////////////////////

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.bold16.copyWith(color: AppColors.textSecondary),
          ),

          const SizedBox(height: 12),

          child,
        ],
      ),
    );
  }
} ///////////////////////////////////////////////////////////////
/// Description Section
///////////////////////////////////////////////////////////////

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(color: ticket.category.color, width: 6),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppStyles.bold16.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 20),

          SelectableText(
            ticket.description,
            style: AppStyles.regular16.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
