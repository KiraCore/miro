import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loaded_state.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loading_state.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class IdentityRegistrarCubit extends Cubit<AIdentityRegistrarState> {
  final IdentityRecordsService _identityRecordsService = globalLocator<IdentityRecordsService>();
  final NetworkModuleBloc _networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final PageReloadController pageReloadController = PageReloadController();

  late final StreamSubscription<NetworkModuleState?> _networkModuleStream;
  WalletAddress? walletAddress;

  IdentityRegistrarCubit() : super(const IdentityRegistrarLoadingState()) {
    _networkModuleStream = _networkModuleBloc.stream.listen(_refreshAfterNetworkUpdate);
  }

  @override
  Future<void> close() {
    _networkModuleStream.cancel();
    return super.close();
  }

  Future<void> setWalletAddress(WalletAddress? walletAddress) async {
    this.walletAddress = walletAddress;
    if (walletAddress != null) {
      await refresh();
    } else {
      emit(const IdentityRegistrarLoadingState());
    }
  }

  Future<void> refresh() async {
    if (walletAddress == null) {
      return;
    }
    ANetworkStatusModel networkStatusModel = _networkModuleBloc.state.networkStatusModel;
    bool changedNetwork = networkStatusModel.uri != pageReloadController.usedUri;
    pageReloadController.handleReloadCall(networkStatusModel);
    int localReloadId = pageReloadController.activeReloadId;

    if (changedNetwork) {
      emit(const IdentityRegistrarLoadingState());
    }

    try {
      IRModel irModel = await _identityRecordsService.getIdentityRecordsByAddress(walletAddress!);
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete) {
        emit(IdentityRegistrarLoadedState(irModel: irModel));
      }
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch identity records for wallet address ${walletAddress!.bech32Address}: Reason: ${e.runtimeType}');
      emit(IdentityRegistrarLoadedState(irModel: IRModel.empty(walletAddress: walletAddress!)));
    }
  }

  Future<void> _refreshAfterNetworkUpdate(NetworkModuleState networkModuleState) async {
    if (networkModuleState.isConnected && state is IdentityRegistrarLoadedState) {
      await refresh();
    }
  }
}
