import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/qr_scanner/qr_scanner.dart';
import 'package:miro/views/widgets/generic/qr_scanner/qr_scanner_controller.dart';

class SaifuScannerDialog extends StatefulWidget {
  final ReceiveQrCallback onReceiveQr;

  const SaifuScannerDialog({
    required this.onReceiveQr,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaifuScannerDialog();
}

class _SaifuScannerDialog extends State<SaifuScannerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 500,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Scan QR-Code from Saifu App'),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 250),
              child: QrScanner(
                fit: BoxFit.contain,
                onReceiveQrCode: _onReceiveQr,
                onError: (BuildContext context, Object error) {
                  print(error);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onReceiveQr(String scanData) {
    if (mounted) {
      context.router.pop();
      widget.onReceiveQr(scanData);
    }
  }
}
