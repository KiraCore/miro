import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/app_config/app_config_state.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/services/cache/app_config_cache_service.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  final AppConfigCacheService appConfigCacheService = AppConfigCacheService();
  final String defaultLocale = 'en';

  AppConfigCubit() : super(AppConfigState(locale: S.delegate.supportedLocales.first.languageCode)) {
    initConfig();
  }

  void initConfig() {
    String locale = appConfigCacheService.getLanguage(defaultValue: defaultLocale);
    emit(AppConfigState(locale: locale));
  }

  Future<void> updateLang(String locale) async {
    await appConfigCacheService.setLanguage(locale);
    emit(AppConfigState(locale: locale));
  }
}
