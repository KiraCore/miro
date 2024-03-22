import 'package:equatable/equatable.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';

class ApiCacheConfigModel extends Equatable {
  final bool cacheEnabledBool;
  final bool forceRequestBool;
  final Duration apiCacheMaxAge;
  final DateTime? cacheStartTime;

  ApiCacheConfigModel({
    this.cacheEnabledBool = true,
    this.forceRequestBool = false,
    Duration? apiCacheMaxAge,
    this.cacheStartTime,
  }) : apiCacheMaxAge = apiCacheMaxAge ?? globalLocator<AppConfig>().defaultApiCacheMaxAge;

  ApiCacheConfigModel copyWith({
    bool? cacheEnabledBool,
    bool? forceRequestBool,
    DateTime? cacheStartTime,
    Duration? apiCacheMaxAge,
  }) {
    return ApiCacheConfigModel(
      cacheEnabledBool: cacheEnabledBool ?? this.cacheEnabledBool,
      forceRequestBool: forceRequestBool ?? this.forceRequestBool,
      cacheStartTime: cacheStartTime ?? this.cacheStartTime,
      apiCacheMaxAge: apiCacheMaxAge ?? this.apiCacheMaxAge,
    );
  }

  @override
  List<Object?> get props => <Object?>[cacheEnabledBool, forceRequestBool, apiCacheMaxAge, cacheStartTime];
}
