import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final String? label;
  final VoidCallback onPressed;

  final Color? backgroundColor;
  final double? elevation;
  final Color? shadowColor;
  final double? borderRadius;
  final double? fontSize;
  final Color? textColor;

  const CustomButton({
    super.key,
    this.text,
    this.label,
    required this.onPressed,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.borderRadius,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = text ?? label ?? '';

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: backgroundColor ?? const Color(0xFFEFF6F9),
          elevation: elevation ?? 8,
          shadowColor: shadowColor ?? Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          displayText,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
