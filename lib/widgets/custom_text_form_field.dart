import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.obscureValue = false,
  });
  final String hintText;
  final Function(String)? onChanged;
  final bool obscureValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
      },
      onChanged: onChanged,
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        hint: Opacity(
          opacity: 0.5,
          child: Text(
            hintText,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
