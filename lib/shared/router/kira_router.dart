import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';

class KiraRouter {
  final NetworkModuleBloc _networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final StackRouter _stackRouter;

  KiraRouter(this._stackRouter);

  KiraRouter.of(BuildContext context) : _stackRouter = AutoRouter.of(context);

  KiraRouter get root => KiraRouter(_stackRouter.root);

  KiraRouter? get parent => _stackRouter.parent() != null ? KiraRouter(_stackRouter.parent()!) : null;

  Future<dynamic> navigate(PageRouteInfo route) async {
    PageRouteInfo pageRouteInfo = _addQueryParameters(route);
    return _stackRouter.navigate(pageRouteInfo);
  }

  Future<bool> pop() async {
    return _stackRouter.pop();
  }

  @optionalTypeArgs
  Future<T?> push<T extends Object?>(PageRouteInfo pageRouteInfo) async {
    PageRouteInfo updatedPageRouteInfo = _addQueryParameters(pageRouteInfo);
    return _stackRouter.push<T>(updatedPageRouteInfo);
  }

  @optionalTypeArgs
  Future<T?> replace<T extends Object?>(PageRouteInfo pageRouteInfo, {OnNavigationFailure? onFailure}) async {
    PageRouteInfo updatedPageRouteInfo = _addQueryParameters(pageRouteInfo);
    return _stackRouter.replace(updatedPageRouteInfo);
  }

  Future<void> replaceAll(List<PageRouteInfo> pageRouteInfoList) async {
    return _stackRouter.replaceAll(pageRouteInfoList);
  }

  PageRouteInfo _addQueryParameters(PageRouteInfo pageRouteInfo) {
    List<PageRouteInfo> pageRouteInfoList = pageRouteInfo.flattened.reversed.toList();
    late PageRouteInfo newPageRouteInfo;

    for (int i = 0; i < pageRouteInfoList.length; i++) {
      PageRouteInfo localPageRouteInfo = pageRouteInfoList[i].copyWith(children: <PageRouteInfo>[]);

      if (i == 0) {
        newPageRouteInfo = _setupTargetRoute(localPageRouteInfo);
      } else {
        newPageRouteInfo = _wrapRoute(localPageRouteInfo, newPageRouteInfo);
      }
    }
    return newPageRouteInfo;
  }

  PageRouteInfo _setupTargetRoute(PageRouteInfo pageRouteInfo) {
    String networkUrl = _networkModuleBloc.state.networkUri.toString();

    return pageRouteInfo.copyWith(
      queryParams: <String, dynamic>{
        RpcBrowserUrlController.rpcQueryParameterKey: networkUrl,
      },
    );
  }

  PageRouteInfo _wrapRoute(PageRouteInfo parentPageRouteInfo, PageRouteInfo childPageRouteInfo) {
    return parentPageRouteInfo.copyWith(
      children: <PageRouteInfo>[childPageRouteInfo],
    );
  }
}
