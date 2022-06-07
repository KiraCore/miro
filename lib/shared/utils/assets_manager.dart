import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:miro/shared/utils/app_logger.dart';

class AssetsManager {
  Future<String> getAsString(String assetName) async {
    try {
      String response = await rootBundle.loadString(assetName);
      return response;
    } catch (_) {
      AppLogger().log(message: 'Failed to load asset [$assetName]', logLevel: LogLevel.error);
      return '';
    }
  }

  Future<Map<String, dynamic>> getAsMap(String assetName) async {
    try {
      String response = await getAsString(assetName);
      Map<String, dynamic> responseData = jsonDecode(response) as Map<String, dynamic>;
      return responseData;
    } catch (_) {
      AppLogger().log(message: 'Failed to load asset [$assetName]', logLevel: LogLevel.error);
      return <String, dynamic>{};
    }
  }
}
