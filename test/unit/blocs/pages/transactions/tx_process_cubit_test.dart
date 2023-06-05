import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/a_tx_process_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/transactions/tx_process_cubit_test.dart --platform chrome --null-assertions
void main() {
  initMockLocator();

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

  group('Tests of [TxProcessCubit] process', () {
    test('Should emit certain states when network is online', () async {
      // Arrange
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel();
      TxProcessCubit<MsgSendFormModel> actualTxProcessCubit = TxProcessCubit<MsgSendFormModel>(
        txMsgType: TxMsgType.msgSend,
        msgFormModel: actualMsgSendFormModel,
      );

      // Assert
      ATxProcessState expectedTxProcessState = const TxProcessLoadingState();

      TestUtils.printInfo('Should [return TxProcessLoadingState] as initial state');
      expect(actualTxProcessCubit.state, expectedTxProcessState);

      // ************************************************************************************************

      // Act
      await actualTxProcessCubit.init();

      // Assert
      TxProcessLoadedState expectedTxProcessLoadedState = TxProcessLoadedState(
        feeTokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      );
      expectedTxProcessState = expectedTxProcessLoadedState;

      TestUtils.printInfo('Should [return TxProcessLoadedState] with feeTokenAmountModel');
      expect(actualTxProcessCubit.state, expectedTxProcessState);

      // ************************************************************************************************

      // Act
      actualTxProcessCubit.submitTransactionForm(signedTxModel);

      // Assert
      expectedTxProcessState = TxProcessConfirmState(
        txProcessLoadedState: expectedTxProcessLoadedState,
        signedTxModel: signedTxModel,
      );

      TestUtils.printInfo('Should [return TxProcessConfirmState] with signedTxModel and previous [TxProcessLoadedState]');
      expect(actualTxProcessCubit.state, expectedTxProcessState);

      // ************************************************************************************************

      // Act
      await actualTxProcessCubit.confirmTransactionForm();

      // Assert
      expectedTxProcessState = TxProcessBroadcastState(
        txProcessLoadedState: expectedTxProcessLoadedState,
        signedTxModel: signedTxModel,
      );

      TestUtils.printInfo('Should [return TxProcessBroadcastState] with signedTxModel and previous [TxProcessLoadedState]');
      expect(actualTxProcessCubit.state, expectedTxProcessState);

      // ************************************************************************************************

      // Act
      await actualTxProcessCubit.editTransactionForm();

      // Assert
      TestUtils.printInfo('Should [return previous TxProcessLoadedState]');
      expect(actualTxProcessCubit.state, expectedTxProcessLoadedState);
    });

    test('Should emit certain states when network is offline', () async {
      // Arrange
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://offline.kira.network/'));
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel();
      TxProcessCubit<MsgSendFormModel> actualTxProcessCubit = TxProcessCubit<MsgSendFormModel>(
        txMsgType: TxMsgType.msgSend,
        msgFormModel: actualMsgSendFormModel,
      );

      // Assert
      ATxProcessState expectedTxProcessState = const TxProcessLoadingState();

      TestUtils.printInfo('Should [return TxProcessLoadingState] as initial state');
      expect(actualTxProcessCubit.state, expectedTxProcessState);

      // ************************************************************************************************

      // Act
      await actualTxProcessCubit.init();

      // Assert
      expectedTxProcessState = const TxProcessErrorState();

      TestUtils.printInfo('Should [return TxProcessErrorState] when network is offline');
      expect(actualTxProcessCubit.state, expectedTxProcessState);
    });
  });
}
