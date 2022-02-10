import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/qr_scanner/qr_scanner.dart';

class SaifuCameraWidget extends StatefulWidget {
  final String? errorMessage;
  final double width;
  final double height;
  final String? Function(String publicAddress) validate;
  final VoidQrReceivedCallback onReceiveQrCode;

  const SaifuCameraWidget({
    required this.validate,
    required this.onReceiveQrCode,
    this.errorMessage,
    this.width = double.infinity,
    this.height = 228,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaifuCameraWidget();
}

class _SaifuCameraWidget extends State<SaifuCameraWidget> {
  String? errorMessage;

  @override
  void initState() {
    errorMessage = widget.errorMessage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: DesignColors.blue1_100,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: QrScanner(
            width: widget.width,
            height: widget.height,
            cameraLoadingWidget: _buildLoadingWidget(),
            errorWidgetBuilder: _buildErrorWidget,
            onReceivedQrCode: (String qrData) {
              bool qrCodeValid = widget.validate(qrData) == null;
              if (qrCodeValid) {
                widget.onReceiveQrCode(qrData);
              }
            }),
      ),
    );
  }
}

Widget _buildLoadingWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      const CenterLoadSpinner(),
      const SizedBox(height: 15),
      Text(
        'Open camera'.toUpperCase(),
        style: const TextStyle(
          color: DesignColors.white_100,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget _buildErrorWidget(CameraException error) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      const Icon(
        Icons.error,
        color: DesignColors.red,
        size: 30,
      ),
      const SizedBox(height: 15),
      Text(
        error.code.toUpperCase(),
        style: const TextStyle(
          color: DesignColors.red,
          fontSize: 12,
        ),
      ),
    ],
  );
}
