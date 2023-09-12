import 'dart:async';
import 'dart:html' as html;

import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_web/camera_web.dart';
import 'package:flutter/widgets.dart';
import 'package:miro/views/widgets/generic/qr_scanner/qr_validator.dart';

/// WEB ONLY USAGE
typedef VoidCameraErrorCallback = ValueChanged<CameraException>;
typedef VoidQrReceivedCallback = ValueChanged<String>;
typedef CameraErrorBuilder = Widget Function(CameraException error);

class QrScanner extends StatefulWidget {
  final double width;
  final double height;
  final Widget cameraLoadingWidget;
  final VoidCameraErrorCallback? onError;
  final CameraErrorBuilder errorWidgetBuilder;
  final VoidQrReceivedCallback onReceivedQrCode;

  const QrScanner({
    required this.cameraLoadingWidget,
    required this.errorWidgetBuilder,
    required this.onReceivedQrCode,
    this.width = 400,
    this.height = 300,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanner();
}

class _QrScanner extends State<QrScanner> {
  Completer<CameraController> cameraCompleter = Completer<CameraController>();
  CameraController? completedCameraController;
  Widget? errorWidget;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initCameraController();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    completedCameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _getCameraBody(),
    );
  }

  Future<void> _initCameraController() async {
    if (!mounted) {
      return;
    }
    List<CameraDescription> cameras = List<CameraDescription>.empty(growable: true);
    try {
      cameras = await availableCameras();

      CameraController cameraController = CameraController(cameras[0], ResolutionPreset.max);
      completedCameraController = cameraController;
      await completedCameraController!.initialize().then((_) {
        cameraCompleter.complete(cameraController);
        _setCameraListener();
        if (!mounted) {
          return;
        }
        setState(() {
          errorWidget = null;
        });
      }).catchError((dynamic e) {
        if (e is CameraException) {
          _onCameraError(e);
        }
      });
    } on CameraException catch (e) {
      await _onCameraError(e);
    }
  }

  void _setCameraListener() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
      _onTick();
    });
  }

  Future<void> _onTick() async {
    String? value = QrValidator.onImageIntercept(_getCurrentVideoElement());
    if (value != null) {
      widget.onReceivedQrCode(value);
    }
  }

  html.VideoElement _getCurrentVideoElement() {
    CameraPlugin cameraPlugin = CameraPlatform.instance as CameraPlugin;
    // TODO(dominik): Write issue on [https://github.com/flutter/plugins/tree/main/packages/camera/camera_web]
    // ignore: invalid_use_of_visible_for_testing_member
    return cameraPlugin.cameras[cameraPlugin.cameras.keys.last]!.videoElement;
  }

  Future<void> _onCameraError(CameraException cameraException) async {
    if (widget.onError != null) {
      widget.onError!(cameraException);
    }
    errorWidget = widget.errorWidgetBuilder(cameraException);
    setState(() {});
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await _initCameraController();
    }
  }

  Widget _getCameraBody() {
    if (cameraCompleter.isCompleted) {
      return CameraPreview(
        completedCameraController!,
      );
    }

    if (errorWidget != null) {
      return errorWidget!;
    }

    return widget.cameraLoadingWidget;
  }
}
