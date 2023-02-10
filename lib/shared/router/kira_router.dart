import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';

class KiraRouter {
  final NetworkModuleBloc _networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final StackRouter _stackRouter;

  KiraRouter(this._stackRouter);

  KiraRouter.of(BuildContext context) : _stackRouter = AutoRouter.of(context);

  KiraRouter get root => KiraRouter(_stackRouter.root);

  KiraRouter? get parent => _stackRouter.parent() != null ? KiraRouter(_stackRouter.parent()!) : null;

  Future<void> navigate(PageRouteInfo route) async {
    PageRouteInfo pageRouteInfo = _addQueryParameters(route);
    await _stackRouter.navigate(pageRouteInfo);
  }

  Future<void> pop() async {
    await _stackRouter.pop();
  }

  Future<void> popUntilRouteWithName(String name) async {
    _stackRouter.popUntilRouteWithName(name);
  }

  Future<void> navigateBack() async {
    _stackRouter.navigateBack();
  }

  Future<void> replaceAll(List<PageRouteInfo> pageRouteInfoList) async {
    await _stackRouter.replaceAll(pageRouteInfoList);
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
