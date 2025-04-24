import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final bool border;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.width,
    required this.height,
    required this.onPressed,
    this.border = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: border ? const BorderSide(color: Colors.teal) : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Optional rounded corners
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
