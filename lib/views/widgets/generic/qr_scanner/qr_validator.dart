import 'dart:html';
import 'dart:js' as js;
import 'dart:typed_data';

import 'package:miro/shared/utils/enum_utils.dart';

enum InversionAttempts {
  dontInvert,
  onlyInvert,
  attemptBoth,
  invertFirst,
}

class QrValidator {
  static String? onImageIntercept(VideoElement videoElement) {
    ImageData videoFrame = _getSingleFrameFromVideo(videoElement);
    js.JsObject? code = _readQrCode(videoFrame: videoFrame);
    if (_isValidQr(code)) {
      String value = code!['data'] as String;
      return value;
    }
    return null;
  }

  static ImageData _getSingleFrameFromVideo(VideoElement videoElement) {
    final CanvasElement canvasElement = CanvasElement(width: 1024, height: 1024);
    CanvasRenderingContext2D canvas = (canvasElement.getContext('2d') as CanvasRenderingContext2D)
      ..drawImage(videoElement, 0, 0);
    ImageData imageData = canvas.getImageData(0, 0, canvasElement.width!, canvasElement.height!);
    return imageData;
  }

  static js.JsObject? _readQrCode({
    required ImageData videoFrame,
    InversionAttempts inversionAttempts = InversionAttempts.dontInvert,
  }) {
    js.JsObject? code = _jsQR(videoFrame.data, videoFrame.width, videoFrame.height, <String, String>{
      'inversionAttempts': EnumUtils.parseToString(inversionAttempts),
    });
    return code;
  }

  /// Call global function jsQR
  /// Import https://github.com/cozmo/jsQR/blob/master/dist/jsQR.js on your index.html at web folder
  static js.JsObject? _jsQR(Uint8ClampedList d, int w, int h, Map<String, String> o) {
    return js.context.callMethod('jsQR', <dynamic>[d, w, h, o]) as js.JsObject?;
  }

  static bool _isValidQr(js.JsObject? code) {
    if (code != null && code['data'] != null) {
      return true;
    }
    return false;
  }
}
