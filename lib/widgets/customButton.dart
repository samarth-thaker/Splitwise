import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double buttonWidth;
  final VoidCallback onPressed;

  const CustomButton(
      {required this.label,
      required this.onPressed,
      required this.buttonWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
          padding:
              WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        ),
        child: Text(
          label,
          style: const TextStyle(
              color: Color.fromARGB(249, 255, 255, 255), fontSize: 16),
        ),
      ),
    );
  }
}
