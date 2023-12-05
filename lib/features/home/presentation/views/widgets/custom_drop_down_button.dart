import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
      {super.key,
      required this.items,
      required this.hint,
      this.onChanged,
      this.value});

  final String hint;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 24),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
