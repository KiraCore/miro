import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/tx_broadcast_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/shared/models/network/error_explorer_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_txs.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/transactions/tx_broadcast_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  SignedTxModel signedTxModel = SignedTxModel(
    txLocalInfoModel: TxLocalInfoModel(
      memo: 'Test transaction',
      feeTokenAmountModel: TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(100),
        tokenAliasModel: TokenAliasModel.local('ukex'),
      ),
      txMsgModel: MsgSendModel(
        fromWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      ),
    ),
    txRemoteInfoModel: const TxRemoteInfoModel(
      accountNumber: '669',
      chainId: 'testnet',
      sequence: '0',
    ),
    signedCosmosTx: CosmosTx.signed(
      body: CosmosTxBody(
        messages: <ProtobufAny>[
          MsgSend(
            fromAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
            toAddress: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
            amount: <CosmosCoin>[
              CosmosCoin(denom: 'ukex', amount: BigInt.from(100)),
            ],
          ),
        ],
        memo: 'Test transaction',
      ),
      authInfo: CosmosAuthInfo(
        signerInfos: <CosmosSignerInfo>[
          CosmosSignerInfo(
            publicKey: CosmosSimplePublicKey(base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8')),
            modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
            sequence: 0,
          ),
        ],
        fee: CosmosFee(
          gasLimit: BigInt.from(200000),
          amount: <CosmosCoin>[
            CosmosCoin(denom: 'ukex', amount: BigInt.from(100)),
          ],
        ),
      ),
      signatures: <CosmosSignature>[
        CosmosSignature(
          s: BigInt.parse('29891932639696445785621460296478741769669531437362733111307189554313331920903'),
          r: BigInt.parse('105119573348349584760845537497362350123555688438276125868382281816491465425317'),
        ),
      ],
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
      actualNetworkModuleBloc.add(NetworkModuleConnectEvent(TestUtils.networkHealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkHealthyModel);

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
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkOfflineModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Act
      await actualTxBroadcastCubit.broadcast(signedTxModel);

      // Assert
      expectedTxBroadcastState = TxBroadcastErrorState(
        errorExplorerModel: ErrorExplorerModel(
          code: 'NETWORK_ERROR',
          message: 'Cannot reach the server. Please check your internet connection.',
          uri: Uri.parse('offline.kira.network'),
          method: 'GET',
          response: null,
        ),
      );

      TestUtils.printInfo('Should return TxBroadcastErrorState() if cannot broadcast transaction');
      expect(actualTxBroadcastCubit.state, expectedTxBroadcastState);
    });
  });
}
