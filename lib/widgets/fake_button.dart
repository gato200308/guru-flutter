import 'package:flutter/material.dart';

class FakeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const FakeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(0xFFEDE7F6),
        foregroundColor: textColor ?? const Color(0xFF4B0082),
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        minimumSize: const Size(0, 48), // 👈 asegura altura mínima
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: FittedBox( // 👈 evita overflow horizontal
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}