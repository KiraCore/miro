import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KiraQrCode extends StatelessWidget {
  final String data;
  final double size;
  final int version;
  final Color foregroundColor;
  final Color backgroundColor;

  const KiraQrCode({
    required this.data,
    this.size = 150,
    this.foregroundColor = Colors.black,
    this.backgroundColor = DesignColors.white_100,
    this.version = QrVersions.auto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 4,
          color: DesignColors.pink_100,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: QrImage(
          data: data,
          version: version,
          embeddedImage: const AssetImage(Assets.assetsLogoSygnet),
          size: size,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          gapless: true,
        ),
      ),
    );
  }
}
