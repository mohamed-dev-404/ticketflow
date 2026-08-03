import 'package:flutter/material.dart';
import 'package:ticketflow/core/utils/assets/app_icons.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.visiblePassword,
    this.validator,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onChange,
    this.textInputAction,
    this.controller,
  });

  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      obscureText: obscureText,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? AppIcons.eyeOffIcon : AppIcons.eyeIcon,
            size: 20,
            color: AppColors.slate600,
          ),
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChange,
      onTap: widget.onTap,
    );
  }
}
