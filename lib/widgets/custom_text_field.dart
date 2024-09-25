import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.onChanged,
      this.obscureText = false});

  Function(String)? onChanged;
  String hintText;
  String labelText;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'This field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        // suffixIcon: const Icon(Icons.email),
      ),
    );
  }
}
