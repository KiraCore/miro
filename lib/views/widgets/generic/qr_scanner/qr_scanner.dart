import 'package:flutter/widgets.dart';
import 'package:miro/views/widgets/generic/qr_scanner/qr_scanner_controller.dart';

/// WEB ONLY USAGE
class QrScanner extends StatefulWidget {
  final ReceiveQrCallback onReceiveQrCode;
  final BoxFit fit;
  final QrScannerErrorCallback? onError;

  const QrScanner({
    required this.onReceiveQrCode,
    this.fit = BoxFit.cover,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanner();
}

class _QrScanner extends State<QrScanner> {
  late final QrScannerController controller;

  @override
  void initState() {
    controller = QrScannerController(onReceiveQrCode: widget.onReceiveQrCode)..init();
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FittedBox(
        fit: widget.fit,
        child: SizedBox(
          width: 400,
          height: 300,
          child: HtmlElementView(
            key: UniqueKey(),
            viewType: controller.webcamIdentifier,
          ),
        ),
      ),
    );
  }
}
