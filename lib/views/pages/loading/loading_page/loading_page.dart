import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/loading_page/loading_page_cubit.dart';
import 'package:miro/blocs/specific_blocs/loading_page/loading_page_state.dart';
import 'package:miro/blocs/specific_blocs/loading_page/states/loading_page_connected_state.dart';
import 'package:miro/blocs/specific_blocs/loading_page/states/loading_page_disconnected_state.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/router_utils.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class LoadingPage extends StatefulWidget {
  final PageRouteInfo? nextPageRouteInfo;

  const LoadingPage({
    this.nextPageRouteInfo,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  final LoadingPageCubit loadingPageCubit = LoadingPageCubit();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocConsumer<LoadingPageCubit, ALoadingPageState>(
      bloc: loadingPageCubit,
      listener: _handleLoadingPageStateChanged,
      builder: (BuildContext context, ALoadingPageState loadingPageState) {
        return Padding(
          padding: AppSizes.defaultMobilePageMargin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.assetsLogoLoading,
                height: 130,
                width: 130,
              ),
              const SizedBox(height: 50),
              ValueListenableBuilder<int>(
                  valueListenable: loadingPageCubit.loadingTimerController.timeNotifier,
                  builder: (_, int remainingTime, __) {
                    String separator = ResponsiveWidget.isSmallScreen(context) ? '\n' : '.';
                    String networkName = loadingPageState.networkStatusModel?.name ?? 'undefined';
                    String parsedRemainingTime = remainingTime > 0 ? '$remainingTime' : '';

                    return Text(
                      'Connecting to <$networkName>$separator Please wait... ${parsedRemainingTime}',
                      textAlign: TextAlign.center,
                      style: textTheme.headline3!.copyWith(
                        color: DesignColors.white1,
                      ),
                    );
                  }),
              const SizedBox(height: 67),
              ValueListenableBuilder<bool>(
                valueListenable: loadingPageCubit.cancelButtonEnabledNotifier,
                builder: (_, bool cancelButtonEnabled, __) {
                  return KiraOutlinedButton(
                    width: 192,
                    disabled: !cancelButtonEnabled,
                    title: 'Cancel connection',
                    onPressed: cancelButtonEnabled ? loadingPageCubit.cancelConnection : null,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleLoadingPageStateChanged(BuildContext context, ALoadingPageState loadingPageState) {
    if (loadingPageState is LoadingPageConnectedState) {
      PageRouteInfo<dynamic> nextRoute = RouterUtils.getNextRouteAfterLoading(widget.nextPageRouteInfo);
      KiraRouter.of(context).navigate(nextRoute);
    } else if (loadingPageState is LoadingPageDisconnectedState) {
      KiraRouter.of(context).navigate(NetworkListRoute(
        nextPageRouteInfo: widget.nextPageRouteInfo,
        connectionErrorType: loadingPageState.connectionErrorType,
        canceledNetworkStatusModel: loadingPageState.networkStatusModel,
      ));
    }
  }
}
