import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    required this.text,
    this.suffixIcon,
    this.width,
    this.validator,
    this.prefixIcon,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.focusNode,
    this.color,
    this.borderColor,
    this.ColorLabel = false,
    this.labelColor,
    this.filled = false,
  });

  final String text;
  final bool enabled;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon, prefixIcon;
  final double? width;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final Color? color, borderColor, labelColor;
  final bool ColorLabel, filled;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width,
      child: TextFormField(
        enabled: enabled,
        // canRequestFocus: false,
        // onTap: onTap,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        focusNode: focusNode,
        decoration: InputDecoration(
            filled: filled,
            fillColor: color,
            labelText: text,
            labelStyle: TextStyle(color: ColorLabel ? labelColor : null),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.grey, width: 1)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.grey, width: 1)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}
