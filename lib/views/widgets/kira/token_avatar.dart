import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';

class TokenAvatar extends StatelessWidget {
  final String? tokenIcon;
  final double size;

  const TokenAvatar({
    required this.tokenIcon,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: DesignColors.blue1_20,
        radius: size / 2,
        child: Padding(
          padding: EdgeInsets.all(size - size * 0.85),
          child: tokenIcon == null || tokenIcon!.isEmpty
              ? Image.asset(Assets.assetsLogoSygnet)
              : Image.network(
                  tokenIcon ?? '',
                  errorBuilder: (_, __, ___) {
                    return const SizedBox();
                  },
                ),
        ),
      ),
    );
  }
}
