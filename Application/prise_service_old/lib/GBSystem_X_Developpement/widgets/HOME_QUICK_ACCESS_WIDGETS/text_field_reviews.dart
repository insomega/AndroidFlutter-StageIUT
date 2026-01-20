import 'package:flutter/material.dart';

class TextFieldReviews extends StatefulWidget {
  const TextFieldReviews(
      {super.key,
      required this.hint,
      this.controller,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.width,
      this.validator,
      this.prefixIcon,
      this.onSaved,
      this.onChanged,
      this.enabled = false});

  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText, enabled;
  final Widget? suffixIcon, prefixIcon;
  final double? width;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  @override
  State<TextFieldReviews> createState() => _TextFieldReviewsState();
}

class _TextFieldReviewsState extends State<TextFieldReviews> {
  bool isFocused = false;
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return TextFormField(
      ///params
      decoration: InputDecoration(
          border: OutlineInputBorder(), label: Text(widget.hint)),
      enabled: !widget.enabled,
      controller: widget.controller,
      onFieldSubmitted: (value) {
        if (widget.onSaved != null) {
          widget.onSaved!(value);
        }
      },
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,

      obscureText: widget.obscureText,

      ////
      minLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done, // Added textInputAction
      maxLines: null,
    );

    // AnimatedContainer(
    //   duration: const Duration(milliseconds: 400),
    //   height: isFocused ? size.height * 0.1 : size.height * 0.06,
    //   width: size.width,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12),
    //       border: Border.all(color: Colors.black, width: 1)),
    //   child: Transform.translate(
    //     offset: Offset(size.width * 0.01, size.height * 0.01),
    //     child: Focus(
    //       onFocusChange: (value) {
    //         setState(() {
    //           isFocused ? isFocused = false : isFocused = true;
    //         });
    //       },
    //       child: TextFormField(
    //         enabled: !widget.enabled,

    //         textInputAction: TextInputAction.done, // Added textInputAction
    //         onFieldSubmitted: (value) {
    //           if (widget.onSaved != null) {
    //             widget.onSaved!(value);
    //           }
    //         },
    //         validator: widget.validator,
    //         onChanged: widget.onChanged,
    //         onSaved: widget.onSaved,
    //         maxLines: 10,
    //         decoration: InputDecoration(
    //             contentPadding: EdgeInsets.symmetric(
    //                 vertical: size.height * 0.001,
    //                 horizontal: size.width * 0.02),
    //             hintText: widget.hint,
    //             hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
    //             border: InputBorder.none,
    //             // border: OutlineInputBorder(
    //             //     borderRadius: BorderRadius.circular(10),
    //             //     borderSide: const BorderSide(color: Colors.grey, width: 1)),
    //             // disabledBorder: OutlineInputBorder(
    //             //     borderRadius: BorderRadius.circular(10),
    //             //     borderSide: const BorderSide(color: Colors.red, width: 1)),
    //             suffixIcon: widget.suffixIcon,
    //             prefixIcon: widget.prefixIcon),
    //         controller: widget.controller,
    //         keyboardType: widget.keyboardType,
    //         obscureText: widget.obscureText,
    //       ),
    //     ),
    //   ),
    // );
  }
}
