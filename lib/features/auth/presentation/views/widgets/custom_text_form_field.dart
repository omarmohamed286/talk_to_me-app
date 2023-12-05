import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.onChanged,
      this.textInputAction = TextInputAction.next, this.maxLength});

  final String labelText;
  final void Function(String value)? onChanged;
  final TextInputAction textInputAction;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      obscureText: labelText == 'Password' ? true : false,
      textInputAction: textInputAction,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '$labelText is required';
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
