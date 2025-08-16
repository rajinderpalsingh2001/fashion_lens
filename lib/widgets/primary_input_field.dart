import 'package:fashion_lens/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

class PrimaryInputField extends StatefulWidget {
  const PrimaryInputField(
      {super.key,required this.controller,
      required this.icon,
      required this.labelText,
      required this.hintText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.none,
      this.minLines,
      this.maxLines,
      this.prefixIcon,
      this.readOnly = false,
      this.onChanged,
      this.onTap,
      this.suffixWidget,
      this.maxLength,
      this.showCounter = true,
      this.showLabel = true,
      this.focusNode,
      this.hintColor,
      this.inputFormatters,
      this.color});

  final TextEditingController? controller;
  final IconData? icon;
  final String? labelText;
  final String? hintText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final IconData? prefixIcon;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final Widget? suffixWidget;
  final int? maxLength;
  final Color? color;
  final Color? hintColor;
  final bool showCounter;
  final bool showLabel;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<PrimaryInputField> createState() => _PrimaryInputFieldState();   
}

class _PrimaryInputFieldState extends State<PrimaryInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      cursorColor: AppTheme.nagarroDarkBlue,
      obscureText: _obscureText,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            widget.color ?? AppTheme.milkyWhite, // Set background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(
          fontSize: 18.0,
        ),
        floatingLabelBehavior: widget.showLabel == false ? FloatingLabelBehavior.never : null,
        floatingLabelStyle: TextStyle(color: AppTheme.nagarroDarkBlue),
        labelText: widget.showLabel == false ? null : widget.labelText,
        hintText: widget.showLabel == false ? widget.labelText : widget.hintText,
        hintStyle: TextStyle(color: widget.hintColor ?? AppTheme.nagarroDarkBlue),
        prefixIcon:
            widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
        icon: widget.icon == null ? null : Icon(widget.icon),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? HugeIcons.strokeRoundedView
                      : HugeIcons.strokeRoundedViewOffSlash,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixWidget,
        contentPadding: const EdgeInsets.all(20.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        errorStyle: TextStyle(color: Colors.redAccent),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
      buildCounter: (context,
          {required currentLength, required isFocused, required maxLength}) {
        if (!widget.showCounter) return Container();
        return widget.maxLength == null
            ? null
            : Text(
                '$currentLength / ${widget.maxLength}',
                style: TextStyle(
                  color: currentLength > (widget.maxLength ?? 0)
                      ? Colors.redAccent
                      : null,
                ),
              );
      },
      textCapitalization: widget.textCapitalization,
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      maxLengthEnforcement: widget.maxLength != null
          ? MaxLengthEnforcement.enforced
          : MaxLengthEnforcement.none,
      maxLength: widget.maxLength,
    );
  }
}
