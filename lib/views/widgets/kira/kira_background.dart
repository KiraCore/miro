import 'package:flutter/material.dart';

class KiraBackground extends StatelessWidget {
  final Widget child;

  const KiraBackground({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: child,
      ),
    );
  }
}
