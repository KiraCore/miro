import 'package:flutter/material.dart';
import 'package:miro/infra/cache/app_config_cache.dart';

abstract class AppConfigProvider extends ChangeNotifier {
  void initConfig();

  String get locale;

  Future<void> updateLang(String lang);
}

class AppConfigProviderImpl extends AppConfigProvider {
  final AppConfigCache appConfigCache = AppConfigCache();

  @override
  late String locale;

  AppConfigProviderImpl() {
    initConfig();
  }

  @override
  void initConfig() {
    locale = appConfigCache.getConfig('language', defaultValue: 'en')!;
    notifyListeners();
  }

  @override
  Future<void> updateLang(String lang) async {
    locale = lang;
    appConfigCache.updateConfig('language', lang);
    notifyListeners();
  }
}
