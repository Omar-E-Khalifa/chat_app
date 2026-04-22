import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap
  });
  final String text;
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      child: FloatingActionButton(
        onPressed:onTap,
        backgroundColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: KPrimaryColor,
          ),
        ),
      ),
    );
  }
}
