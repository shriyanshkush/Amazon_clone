import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final String text;
  final VoidCallback onTap;

  const CustomButton({Key? key, required this.text, required this.onTap,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(color: color==null?Colors.white:Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Adjust for rounded corners
        ),
        minimumSize: const Size(double.infinity, 50), // Full-width with a height of 50
      ),
    );
  }
}
