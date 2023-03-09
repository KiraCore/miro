import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';

class TokenAvatar extends StatelessWidget {
  final String? iconUrl;
  final double size;

  const TokenAvatar({
    required this.iconUrl,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: DesignColors.grey2,
      ),
      child: CircleAvatar(
        backgroundColor: DesignColors.background,
        radius: size / 2,
        child: Padding(
          padding: EdgeInsets.all(size - size * 0.75),
          child: iconUrl == null || iconUrl!.isEmpty
              ? Image.asset(Assets.assetsLogoSygnet)
              : Image.network(
                  iconUrl ?? '',
                  errorBuilder: (_, __, ___) {
                    return const SizedBox();
                  },
                ),
        ),
      ),
    );
  }
}
