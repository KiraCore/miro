import 'dart:async';
import 'dart:html';
import 'dart:js' as js;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:miro/shared/app_logger.dart';
import 'package:miro/shared/utils/enums.dart';
import 'package:miro/views/widgets/generic/qr_scanner/constants/index.dart';

// Note: only work over https or localhost
//
// - https://medium.com/@mk.pyts/how-to-access-webcam-video-stream-in-flutter-for-web-1bdc74f2e9c7
// - https://github.com/cozmo/jsQR

typedef QrScannerErrorCallback = void Function(BuildContext context, Object error);
typedef ReceiveQrCallback = void Function(String qrValue);

class QrScannerController {
  final String webcamIdentifier = 'webcamVideoElement${UniqueKey().toString()}';
  final Duration tickTime;
  final ReceiveQrCallback onReceiveQrCode;
  final VideoElement _video = VideoElement();
  final CanvasElement _canvasElement = CanvasElement();

  late CanvasRenderingContext2D _canvas;
  late MediaStream _stream;
  late Timer _timer;

  QrScannerController({
    required this.onReceiveQrCode,
    this.tickTime = const Duration(milliseconds: 20),
  });

  void init() {
    _registerViewFactory();
    _getAccessToWebcamStream();
    _canvas = _canvasElement.getContext('2d') as CanvasRenderingContext2D;
    _timer = Timer.periodic(tickTime, (Timer timer) {
      _onTick();
    });
  }

  Future<void> disposeCamera() async {
    _timer.cancel();
    _video.pause();
    await Future<void>.delayed(const Duration(seconds: 2));
    try {
      _stream.getTracks().forEach((MediaStreamTrack track) {
        track.stop();
      });
    } catch (e) {
      AppLogger().log(message: e.toString());
    }
  }

  void _registerViewFactory() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(webcamIdentifier, (int viewId) => _video);
  }

  Future<void> _getAccessToWebcamStream({bool playsInLine = true}) async {
    _stream = await _getUserMedia();
    _video
      ..srcObject = _stream
      ..setAttribute('playsinline', '$playsInLine');
    await _video.play();
  }

  Future<MediaStream> _getUserMedia({FacingMode facingMode = FacingMode.environment}) async {
    String finalFacingMode = enumToString(facingMode);
    MediaStream userMedia = await window.navigator.getUserMedia(
      video: <String, String>{'facingMode': finalFacingMode},
    );
    return userMedia;
  }

  void _onTick() {
    if (_video.readyState == VideoReadyState.haveEnoughData.index) {
      _onImageIntercept();
    }
  }

  void _onImageIntercept() {
    ImageData videoFrame = _getSingleFrameFromVideo();
    js.JsObject? code = _readQrCode(videoFrame: videoFrame);
    if (_isValidQr(code)) {
      String value = code!['data'] as String;
      onReceiveQrCode(value);
    }
  }

  ImageData _getSingleFrameFromVideo() {
    _canvasElement
      ..width = 1024
      ..height = 1024;
    _canvas.drawImage(_video, 0, 0);
    ImageData imageData = _canvas.getImageData(0, 0, _canvasElement.width!, _canvasElement.height!);
    return imageData;
  }

  js.JsObject? _readQrCode({
    required ImageData videoFrame,
    InversionAttempts inversionAttempts = InversionAttempts.dontInvert,
  }) {
    js.JsObject? code = _jsQR(videoFrame.data, videoFrame.width, videoFrame.height, <String, String>{
      'inversionAttempts': enumToString(inversionAttempts),
    });
    return code;
  }

  /// Call global function jsQR
  /// Import https://github.com/cozmo/jsQR/blob/master/dist/jsQR.js on your index.html at web folder
  js.JsObject? _jsQR(Uint8ClampedList d, int w, int h, Map<String, String> o) {
    return js.context.callMethod('jsQR', <dynamic>[d, w, h, o]) as js.JsObject?;
  }

  bool _isValidQr(js.JsObject? code) {
    if (code != null && code['data'] != null) {
      return true;
    }
    return false;
  }
}
