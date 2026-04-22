import 'package:chat_app/constants.dart';

import 'package:flutter/material.dart';

class customChatField extends StatelessWidget {
  const customChatField({
    super.key,
    required this.onSubmitted,
    required this.controller,
    required this.onPressed,
  });

  final Function(String) onSubmitted;
  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        cursorColor: KPrimaryColor,
        style: TextStyle(color: KPrimaryColor),
        decoration: InputDecoration(
          border: CustomBorderDesign(width: 1),
          focusedBorder: CustomBorderDesign(width: 1.5),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.send,
              color: KPrimaryColor,
            ),
          ),
          hint: Opacity(
            opacity: 0.5,
            child: Text(
              "Message",
              style: TextStyle(
                color: KPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder CustomBorderDesign({required double width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: KPrimaryColor,
        width: width,
      ),
    );
  }
}
