import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
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
    this.foregroundColor = DesignColors.black,
    this.backgroundColor = DesignColors.white1,
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
          color: DesignColors.white1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: QrImage(
          data: data,
          version: version,
          size: size,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          gapless: true,
        ),
      ),
    );
  }
}
