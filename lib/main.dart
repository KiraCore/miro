import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/theme_config.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/app_list_providers.dart';
import 'package:miro/shared/router/guards/auth_guard.dart';
import 'package:miro/shared/router/guards/connection_guard.dart';
import 'package:miro/shared/router/guards/navigation_guard.dart';
import 'package:miro/shared/router/guards/pages/loading_page_guard.dart';
import 'package:miro/shared/router/guards/pages/tx_broadcast_page_guard.dart';
import 'package:miro/shared/router/guards/pages/tx_confirm_page_guard.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/assets_manager.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await initLocator();
  await globalLocator<CacheManager>().init();

  Map<String, dynamic> configJson = await AssetsManager().getAsMap('assets/network_list_config.json');
  globalLocator<AppConfig>().init(configJson);

  globalLocator<NetworkModuleBloc>().add(NetworkModuleInitEvent());
  globalLocator<NetworkListCubit>().initNetworkStatusModelList();

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
  final ConnectionGuard connectionGuard = ConnectionGuard();
  late final AppRouter appRouter = AppRouter(
    authGuard: AuthGuard(),
    txConfirmPageGuard: TxConfirmPageGuard(),
    navigationGuard: NavigationGuard(),
    txBroadcastPageGuard: TxBroadcastPageGuard(),
    connectionGuard: connectionGuard,
    loadingPageGuard: LoadingPageGuard(connectionGuard: connectionGuard),
  );

  @override
  void initState() {
    super.initState();
    precacheImage(const AssetImage(Assets.assetsLogoSygnet), context);
    precacheImage(const AssetImage(Assets.assetsLogoLoading), context);
    precacheImage(const AssetImage(Assets.imagesBackground), context);
    precacheImage(const AssetImage(Assets.imagesBackgroundDrawer), context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;

        return Consumer<AppConfigProvider>(
          builder: (_, AppConfigProvider value, Widget? child) {
            return MaterialApp.router(
              title: 'Kira Network',
              routeInformationParser: appRouter.defaultRouteParser(),
              routerDelegate: appRouter.delegate(),
              debugShowCheckedModeBanner: false,
              locale: Locale(
                globalLocator<AppConfigProvider>().locale,
                globalLocator<AppConfigProvider>().locale.toUpperCase(),
              ),
              theme: ThemeConfig.buildTheme(isSmallScreen: isSmallScreen),
              builder: (_, Widget? routerWidget) {
                return Scaffold(
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: routerWidget as Widget,
                  ),
                );
              },
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}
