import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/loading_page/loading_page_cubit.dart';
import 'package:miro/blocs/specific_blocs/loading_page/loading_page_state.dart';
import 'package:miro/blocs/specific_blocs/loading_page/states/loading_page_connected_state.dart';
import 'package:miro/blocs/specific_blocs/loading_page/states/loading_page_disconnected_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/router_utils.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class LoadingPage extends StatefulWidget {
  final RouteMatch<dynamic>? nextRoute;

  const LoadingPage({
    this.nextRoute,
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              Assets.assetsLogoLoading,
              height: 130,
              width: 130,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Connecting to <${loadingPageState.networkStatusModel?.name ?? ''}>. Please wait...',
                  style: textTheme.headline3!.copyWith(
                    color: DesignColors.white_100,
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: loadingPageCubit.loadingTimerController.timeNotifier,
                  builder: (_, int remainingTime, __) {
                    if (remainingTime == 0) {
                      return const SizedBox();
                    }
                    return Text(
                      '${remainingTime}',
                      style: textTheme.headline3!.copyWith(
                        color: DesignColors.white_100,
                      ),
                    );
                  },
                ),
              ],
            ),
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
        );
      },
    );
  }

  void _handleLoadingPageStateChanged(BuildContext context, ALoadingPageState loadingPageState) {
    if (loadingPageState is LoadingPageConnectedState) {
      PageRouteInfo<dynamic> nextRoute = RouterUtils.getNextRouteAfterLoading(widget.nextRoute);
      AutoRouter.of(context).navigate(nextRoute);
    } else if (loadingPageState is LoadingPageDisconnectedState) {
      AutoRouter.of(context).replace(NetworkListRoute(
        nextRoute: widget.nextRoute,
        connectionErrorType: loadingPageState.connectionErrorType,
        canceledNetworkStatusModel: loadingPageState.networkStatusModel,
      ));
    }
  }
}
