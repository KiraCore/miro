import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/tx_broadcast_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_txs.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/transactions/tx_broadcast/tx_broadcast_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  NetworkUnknownModel healthyNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
  );

  NetworkUnknownModel offlineNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network'),
    name: 'offline-mainnet',
  );

  NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: 'v0.4.22',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
      activeValidators: 319,
      totalValidators: 475,
    ),
  );

  NetworkOfflineModel networkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network'),
    name: 'offline-mainnet',
  );

  SignedTxModel signedTxModel = SignedTxModel(
    publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
    txLocalInfoModel: TxLocalInfoModel(
      memo: 'Test transaction',
      feeTokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(100),
        tokenAliasModel: TokenAliasModel.local('ukex'),
      ),
      txMsgModel: MsgSendModel(
        fromWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      ),
    ),
    txRemoteInfoModel: const TxRemoteInfoModel(
      accountNumber: '669',
      chainId: 'testnet',
      sequence: '0',
    ),
    signatureModel: const SignatureModel(
      signature: 'hd+WiCdVaMcTDshpEsgkn6VOWdXAOV7QKUZEIxMRhLYzSD8bK7RQcn9jl/2I2TLa4QBoCuAStXwOircabaVQzg==',
    ),
  );

  group('Tests for TxBroadcastCubit', () {
    test('Should emit certain states when network is online while broadcasting', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
      TxBroadcastCubit actualTxBroadcastCubit = TxBroadcastCubit();

      // Assert
      ATxBroadcastState expectedTxBroadcastState = TxBroadcastLoadingState();

      TestUtils.printInfo('Should return TxBroadcastLoadingState() as initial state');
      expect(actualTxBroadcastCubit.state, expectedTxBroadcastState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(healthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkHealthyModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Act
      await actualTxBroadcastCubit.broadcast(signedTxModel);

      // Assert
      expectedTxBroadcastState = TxBroadcastCompletedState(
        broadcastRespModel: BroadcastRespModel.fromDto(
          BroadcastResp.fromJson(MockApiKiraTxs.defaultResponse),
        ),
      );

      TestUtils.printInfo('Should return TxBroadcastCompletedState() with BroadcastRespModel if broadcasting transaction succeeded');
      expect(actualTxBroadcastCubit.state, expectedTxBroadcastState);
    });

    test('Should emit certain states when network is offline while broadcasting', () async {
      // Arrange
      NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
      TxBroadcastCubit actualTxBroadcastCubit = TxBroadcastCubit();

      // Assert
      ATxBroadcastState expectedTxBroadcastState = TxBroadcastLoadingState();

      TestUtils.printInfo('Should return TxBroadcastLoadingState() as initial state');
      expect(actualTxBroadcastCubit.state, expectedTxBroadcastState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkOfflineModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Act
      await actualTxBroadcastCubit.broadcast(signedTxModel);

      // Assert
      expectedTxBroadcastState = TxBroadcastErrorState();

      TestUtils.printInfo('Should return TxBroadcastErrorState() if cannot broadcast transaction');
      expect(actualTxBroadcastCubit.state, expectedTxBroadcastState);
    });
  });
}
