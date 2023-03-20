import 'package:flutter/material.dart';
import 'package:miro/infra/services/cache/app_config_cache_service.dart';

abstract class AppConfigProvider extends ChangeNotifier {
  void initConfig();

  String get locale;

  Future<void> updateLang(String language);
}

class AppConfigProviderImpl extends AppConfigProvider {
  final AppConfigCacheService appConfigCacheService = AppConfigCacheService();

  @override
  late String locale;

  AppConfigProviderImpl() {
    initConfig();
  }

  @override
  void initConfig() {
    locale = appConfigCacheService.getLanguage(defaultValue: 'en');
    notifyListeners();
  }

  @override
  Future<void> updateLang(String language) async {
    locale = language;
    await appConfigCacheService.setLanguage(language);
    notifyListeners();
  }
}
