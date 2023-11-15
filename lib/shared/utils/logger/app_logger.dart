import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

// ignore_for_file: avoid_print
class AppLogger {
  static const bool _apiDebugEnabled = true;

  static final AppLogger _appLogger = AppLogger._internal();

  factory AppLogger() => _appLogger;

  AppLogger._internal();

  final Logger _logger = Logger();

  void log({required String message, LogLevel logLevel = LogLevel.warning}) {
    switch (logLevel) {
      case LogLevel.trace:
        _logger.t(message);
        break;
      case LogLevel.debug:
        _logger.d(message);
        break;
      case LogLevel.info:
        _logger.i(message);
        break;
      case LogLevel.warning:
        _logger.w(message);
        break;
      case LogLevel.error:
        _logger.e(message);
        break;
      case LogLevel.fatal:
        _logger.f(message);
        break;
    }
  }

  void logApiRequest(RequestOptions requestOptions) {
    if (_apiDebugEnabled) {
      String urlString = '${requestOptions.method} | ${requestOptions.uri.toString()}';
      String hash = _createIdentityHash(urlString);
      print('\x1B[34m(#$hash) API REQUEST:\t\x1B[0m$urlString');
    }
  }

  void logApiInterceptor(RequestOptions requestOptions, String message) {
    if (_apiDebugEnabled) {
      String urlString = '${requestOptions.method} | ${requestOptions.uri.toString()}';
      String hash = _createIdentityHash(urlString);
      print('\x1B[34m(#$hash) INTERCEPTOR:\t\x1B[0m$message');
    }
  }

  String _createIdentityHash(String message) {
    String hash = Sha256.encrypt(message).toString();
    return hash.substring(0, 8);
  }
}
