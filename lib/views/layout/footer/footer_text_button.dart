import 'package:flutter/material.dart';

class FooterTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const FooterTextButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
