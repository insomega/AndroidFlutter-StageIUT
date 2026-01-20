import 'package:flutter/material.dart';

class GBSystem_Root_EditViewWidget extends StatelessWidget {
  const GBSystem_Root_EditViewWidget(
      {super.key,
      required this.label,
      this.enabled = true,
      this.controller,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.width,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.onTap,
      this.onSuffixTap,
      this.focusNode});

  final Widget label;
  final bool enabled;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon, prefixIcon;
  final double? width;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap, onSuffixTap;
  final FocusNode? focusNode;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: TextFormField(
          enabled: enabled,
          onTap: onTap,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
          focusNode: focusNode,
          decoration: InputDecoration(
              label: label,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1)),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon),
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ),
    );
  }
}
