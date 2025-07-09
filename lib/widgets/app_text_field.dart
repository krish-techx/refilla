import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final bool isNumber;
  final bool isDecimal;
  final bool isRequired;

  const AppTextField({
    super.key,
    required this.controller,
    this.hint,
    this.isNumber = false,
    this.isDecimal = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType:
            isNumber
                ? TextInputType.number
                : isDecimal
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (val) {
          if (isRequired && (val == null || val.isEmpty)) {
            return 'Required';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
