import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/theme_dark.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/app_list_providers.dart';
import 'package:miro/shared/guards/auth_guard.dart';
import 'package:miro/shared/guards/navigation_guard.dart';
import 'package:miro/shared/guards/url_parameters_guard.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/assets_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await initLocator();
  await globalLocator<CacheManager>().init();

  Map<String, dynamic> configJson = await AssetsManager().getAsMap('assets/network_list_config.json');
  globalLocator<AppConfig>().init(configJson);

  globalLocator<NetworkModuleBloc>().add(NetworkModuleInitEvent());
  globalLocator<NetworkListCubit>().initNetworkStatusModelList();

  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: appListProviders,
      child: const CoreApp(),
    ),
  );
}

class CoreApp extends StatefulWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoreApp();
}

class _CoreApp extends State<CoreApp> {
  final AppRouter appRouter = AppRouter(
    authGuard: AuthGuard(),
    urlParametersGuard: UrlParametersGuard(),
    navigationGuard: NavigationGuard(),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfigProvider>(
      builder: (_, AppConfigProvider value, Widget? child) {
        return MaterialApp.router(
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
          debugShowCheckedModeBanner: false,
          locale: Locale(
            globalLocator<AppConfigProvider>().locale,
            globalLocator<AppConfigProvider>().locale.toUpperCase(),
          ),
          theme: buildDarkTheme(globalLocator<AppConfigProvider>().locale),
          builder: (_, Widget? routerWidget) {
            return routerWidget as Widget;
          },
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
