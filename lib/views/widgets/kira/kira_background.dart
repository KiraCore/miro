import 'package:flutter/material.dart';
import 'package:miro/generated/assets.dart';

class KiraBackground extends StatelessWidget {
  final Widget child;

  const KiraBackground({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
