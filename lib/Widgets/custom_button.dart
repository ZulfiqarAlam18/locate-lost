import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final String size; // "small" or "large"
  final String label;
  final bool border; // true if you want a teal border

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.size,
    required this.label,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    // Set button size based on 'size' input
    final double buttonWidth = size == "large" ? 240 : 130;
    final double buttonHeight = size == "large" ? 60 : 50;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: border ? const BorderSide(color: Colors.teal) : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
















