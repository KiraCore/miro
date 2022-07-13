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
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: DesignColors.gray1_100,
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
