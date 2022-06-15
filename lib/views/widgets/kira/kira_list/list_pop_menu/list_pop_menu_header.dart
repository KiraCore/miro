import 'package:flutter/material.dart';

class ListPopMenuHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClearPressed;

  const ListPopMenuHeader({
    required this.title,
    this.onClearPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      trailing: onClearPressed == null
          ? null
          : IconButton(
              icon: const Text('Clear'),
              onPressed: onClearPressed,
            ),
    );
  }
}
