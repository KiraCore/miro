import 'package:flutter/material.dart';

class KiraOutlinedButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Widget child;
  final double? height;
  final double? width;

  const KiraOutlinedButton({
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFF6489B4),
          ),
        ),
        child: SizedBox(
          height: height ?? 50,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
