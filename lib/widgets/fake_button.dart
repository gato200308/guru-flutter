import 'package:flutter/material.dart';

class FakeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FakeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
