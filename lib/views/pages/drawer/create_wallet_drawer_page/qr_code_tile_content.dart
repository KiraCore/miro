import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic.dart';
import 'package:miro/views/widgets/kira/kira_qr_code.dart';

class QrCodeTileContent extends StatelessWidget {
  final Mnemonic mnemonic;

  const QrCodeTileContent({
    required this.mnemonic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: KiraQrCode(
        data: mnemonic.value,
        size: 180,
      ),
    );
  }
}
