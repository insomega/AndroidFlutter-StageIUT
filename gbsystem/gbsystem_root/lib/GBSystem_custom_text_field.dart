import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.width,
    this.height,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.focusNode,
    this.textStyle,
    this.contentPadding,
    this.color,
    this.borderColor,
    this.colorLabel = false,
    this.labelColor,
    this.filled = false,
    this.readOnly = false,
  });

  /// Label du champ
  final String text;

  /// Activation du champ
  final bool enabled;

  /// Contrôleur texte
  final TextEditingController? controller;

  /// Type de clavier (email, number, etc.)
  final TextInputType? keyboardType;

  /// Mot de passe
  final bool obscureText;

  /// Icônes
  final Widget? suffixIcon, prefixIcon;

  /// Dimensions
  final double? width, height;

  /// Validateur
  final String? Function(String?)? validator;

  /// Callbacks
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;

  /// Focus
  final FocusNode? focusNode;

  /// Style texte
  final TextStyle? textStyle;

  /// Padding interne
  final EdgeInsetsGeometry? contentPadding;

  /// Couleurs
  final Color? color, borderColor, labelColor;

  /// Label colorisé
  final bool colorLabel;

  /// Fond rempli
  final bool filled;

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: height,
      width: width ?? size.width,
      child: TextFormField(
        enabled: enabled,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        focusNode: focusNode,
        style: textStyle,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          filled: filled,
          fillColor: color,
          labelText: text,
          labelStyle: textStyle ?? TextStyle(color: colorLabel ? labelColor : null),
          hintStyle: textStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey,
              width: 1,
            ),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({super.key, this.controller, this.keyboardType, this.obscureText = false, required this.text, this.suffixIcon, this.width, this.validator, this.prefixIcon, this.onSaved, this.onChanged, this.onTap, this.enabled = true, this.focusNode});

//   final String text;
//   final bool enabled;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final bool obscureText;
//   final Widget? suffixIcon, prefixIcon;
//   final double? width;
//   final String? Function(String?)? validator;
//   final void Function(String)? onChanged;
//   final void Function(String?)? onSaved;
//   final void Function()? onTap;
//   final FocusNode? focusNode;
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return SizedBox(
//       width: width ?? size.width,
//       child: TextFormField(
//         enabled: enabled,
//         onTap: onTap,
//         validator: validator,
//         onChanged: onChanged,
//         onSaved: onSaved,
//         focusNode: focusNode,
//         decoration: InputDecoration(
//             labelText: text, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey, width: 1)), disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey, width: 1)), suffixIcon: suffixIcon, prefixIcon: prefixIcon),
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//       ),
//     );
//   }
// }
