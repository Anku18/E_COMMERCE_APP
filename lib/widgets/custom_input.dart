import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? isPasswordFields;

  CustomInput({
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.isPasswordFields,
  });

  @override
  Widget build(BuildContext context) {
    bool _isPasswordFields = isPasswordFields ?? false;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: _isPasswordFields,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
