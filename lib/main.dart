import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/theme_config.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/shared/router/guards/auth_guard.dart';
import 'package:miro/shared/router/guards/connection_guard.dart';
import 'package:miro/shared/router/guards/navigation_guard.dart';
import 'package:miro/shared/router/guards/pages/loading_page_guard.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/assets_manager.dart';

Future<void> main() async {
  // disable default context menu
  window.document.onContextMenu.listen((MouseEvent mouseEvent) => mouseEvent.preventDefault());

  await initLocator();
  await globalLocator<ICacheManager>().init();

  Map<String, dynamic> configJson = await AssetsManager().getAsMap('assets/network_list_config.json');
  globalLocator<AppConfig>().init(configJson);

  globalLocator<NetworkModuleBloc>().add(NetworkModuleInitEvent());
  globalLocator<NetworkListCubit>().initNetworkStatusModelList();
  await globalLocator<IdentityRegistrarCubit>().refresh();

  runApp(const CoreApp());
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
    navigationGuard: NavigationGuard(),
    connectionGuard: connectionGuard,
    loadingPageGuard: LoadingPageGuard(connectionGuard: connectionGuard),
  );

  @override
  void initState() {
    super.initState();
    precacheImage(const AssetImage(Assets.assetsLogoSignet), context);
    precacheImage(const AssetImage(Assets.assetsLogoLoading), context);
  }

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;

        return MaterialApp.router(
          onGenerateTitle: (BuildContext context) => S.of(context).kiraNetwork,
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'EN'),
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
          localizationsDelegates: GlobalMaterialLocalizations.delegates +
              <LocalizationsDelegate<dynamic>>[
                S.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
