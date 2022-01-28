import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/specific_blocs/scaffold_menu/scaffold_menu_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/utils/browser_utils.dart';
import 'package:provider/provider.dart';

class CoreNavigatorObserver extends AutoRouterObserver {
  final BuildContext context;

  CoreNavigatorObserver(this.context);

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    Provider.of<ScaffoldMenuCubit>(context).updateRoutePath(route.path);
    prepareUrl();
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    Provider.of<ScaffoldMenuCubit>(context).updateRoutePath(route.path);
    prepareUrl();
  }

  void prepareUrl() {
    Future<void>.delayed(const Duration(milliseconds: 100)).whenComplete(() {
      NetworkProvider networkProvider = globalLocator<NetworkProvider>();
      Uri currentUri = Uri.base;
      if (!networkProvider.isConnected) {
        return;
      }
      if (networkProvider.networkUrl != currentUri.queryParameters['rpc']) {
        BrowserUtils.replaceUrl(
          currentUri.replace(
            queryParameters: <String, dynamic>{'rpc': networkProvider.networkUrl},
          ),
        );
      }
    });
  }
}
