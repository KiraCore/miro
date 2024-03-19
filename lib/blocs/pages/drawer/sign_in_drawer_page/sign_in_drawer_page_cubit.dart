import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_refresh_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

class SignInDrawerPageCubit extends Cubit<SignInDrawerPageState> {
  final int refreshIntervalSeconds = globalLocator<AppConfig>().defaultRefreshIntervalSeconds;
  final NetworkModuleBloc _networkModuleBloc = globalLocator<NetworkModuleBloc>();
  late final StreamSubscription<NetworkModuleState> _networkModuleStateSubscription;

  SignInDrawerPageCubit() : super(const SignInDrawerPageState(disabledBool: true)) {
    _refreshDrawer();
    _networkModuleStateSubscription = _networkModuleBloc.stream.listen(_refreshDrawer);
  }

  void refreshNetwork() {
    _networkModuleBloc.add(NetworkModuleRefreshEvent());
    emit(state.copyWith(refreshUnlockingDateTime: DateTime.now().add(Duration(seconds: refreshIntervalSeconds))));
  }

  @override
  Future<void> close() {
    _networkModuleStateSubscription.cancel();
    return super.close();
  }

  void _refreshDrawer([NetworkModuleState? networkModuleState]) {
    TokenDefaultDenomModel tokenDefaultDenomModel = _networkModuleBloc.tokenDefaultDenomModel;
    bool disabledBool = tokenDefaultDenomModel.valuesFromNetworkExistBool == false;
    DateTime expirationDateTime = _calculateExpirationDateTime();
    if (_networkModuleBloc.state.isRefreshing) {
      emit(state.copyWith(disabledBool: disabledBool, refreshingBool: true, refreshUnlockingDateTime: expirationDateTime));
    } else {
      emit(state.copyWith(disabledBool: disabledBool, refreshingBool: false, refreshUnlockingDateTime: expirationDateTime));
    }
  }

  DateTime _calculateExpirationDateTime() {
    DateTime calculationStartDateTime = DateTime.now();

    // Last refresh of currently connected network from now, which refreshes only during NetworkModuleRefreshEvent
    // Can take bigger values than 60s because of long response time
    Duration lastRefreshFromNow = calculationStartDateTime.difference(_networkModuleBloc.state.networkStatusModel.lastRefreshDateTime!);

    // Last occurrence of NetworkModuleRefreshEvent from now
    // If lastRefreshFromNow is more than 60s (e.g. 78s), lastAutoRefreshEventFromNow will equal the remainder of dividing it by 60s (e.g. 18s)
    // Milliseconds were used to avoid inaccurate rounding by the Duration class (e.g. 59.9s -> 59.0s)
    Duration lastAutoRefreshEventFromNow =
        lastRefreshFromNow.inSeconds > 60 ? Duration(milliseconds: lastRefreshFromNow.inMilliseconds % 60000) : lastRefreshFromNow;

    Duration timeUntilNextRefresh = Duration(seconds: refreshIntervalSeconds) - lastAutoRefreshEventFromNow;
    return calculationStartDateTime.add(timeUntilNextRefresh);
  }
}
