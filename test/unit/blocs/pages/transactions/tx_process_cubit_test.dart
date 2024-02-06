import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/a_tx_process_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/network_properties_model.dart';
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
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  AuthCubit actualAuthCubit = globalLocator<AuthCubit>();
  SignedTxModel signedTxModel = SignedTxModel(
    publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
    txLocalInfoModel: TxLocalInfoModel(
      memo: 'Test transaction',
      feeTokenAmountModel: TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(100),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      ),
      txMsgModel: MsgSendModel(
        fromWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
      ),
    ),
    txRemoteInfoModel: const TxRemoteInfoModel(
      accountNumber: '669',
      chainId: 'testnet-9',
      sequence: '106',
    ),
    signatureModel: const SignatureModel(
      signature: 'Ahamy8xzwacGyxSPElYrvOrMIEL1MbmeS6fsiR9u73QhD3gdbVcwNv0/qRA+jziF2XV8A9eMbvunUOsYxotG6g==',
    ),
  );

  group('Tests of [TxProcessCubit] initialization', () {
    test('Should return [TxProcessLoadedState] if [formEnabledBool] param is equal [true] (default value)', () async {
      // Arrange
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
      await actualAuthCubit.signIn(TestUtils.wallet);
      await actualTxProcessCubit.init();

      // Assert
      expectedTxProcessState = TxProcessLoadedState(
        feeTokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        networkPropertiesModel: NetworkPropertiesModel(
          minTxFee: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TestUtils.kexTokenAliasModel,
          ),
          minIdentityApprovalTip: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(200),
            tokenAliasModel: TestUtils.kexTokenAliasModel,
          ),
        ),
      );

      TestUtils.printInfo('Should [return TxProcessLoadedState] with feeTokenAmountModel');
      expect(actualTxProcessCubit.state, expectedTxProcessState);
    });

    test('Should return [TxProcessConfirmState] if [formEnabledBool] param is equal [false]', () async {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        recipientWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        senderWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
      )..memo = 'Test transaction';

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
      await actualAuthCubit.signIn(TestUtils.wallet);
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      await actualTxProcessCubit.init(formEnabledBool: false);

      // Assert
      expectedTxProcessState = TxProcessConfirmState(
        txProcessLoadedState: TxProcessLoadedState(
          feeTokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TestUtils.kexTokenAliasModel,
          ),
          networkPropertiesModel: NetworkPropertiesModel(
            minTxFee: TokenAmountModel(
              defaultDenominationAmount: Decimal.fromInt(100),
              tokenAliasModel: TestUtils.kexTokenAliasModel,
            ),
            minIdentityApprovalTip: TokenAmountModel(
              defaultDenominationAmount: Decimal.fromInt(200),
              tokenAliasModel: TestUtils.kexTokenAliasModel,
            ),
          ),
        ),
        signedTxModel: signedTxModel,
      );

      TestUtils.printInfo('Should [return TxProcessLoadedState] with feeTokenAmountModel');
      expect(actualTxProcessCubit.state, expectedTxProcessState);
    });
  });

  group('Tests of [TxProcessCubit] process', () {
    test('Should emit certain states when network is online', () async {
      // Arrange
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://unhealthy.kira.network/'));
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
      ATxProcessState expectedTxProcessLoadedState = const TxProcessErrorState();

      TestUtils.printInfo('Should [return TxProcessErrorState] when wallet is not set up and [init] method is called');
      expect(actualTxProcessCubit.state, expectedTxProcessLoadedState);

      // ************************************************************************************************

      // Act
      await actualAuthCubit.signIn(TestUtils.wallet);
      await actualTxProcessCubit.init();

      // Assert
      expectedTxProcessLoadedState = const TxProcessErrorState(accountErrorBool: true);

      TestUtils.printInfo('Should [return TxProcessErrorState] with [accountErrorBool] when wallet does not have assigned account number');
      expect(actualTxProcessCubit.state, expectedTxProcessLoadedState);

      // ************************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      await actualTxProcessCubit.init();

      // Assert
      expectedTxProcessLoadedState = TxProcessLoadedState(
        feeTokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        networkPropertiesModel: NetworkPropertiesModel(
          minTxFee: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TestUtils.kexTokenAliasModel,
          ),
          minIdentityApprovalTip: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(200),
            tokenAliasModel: TestUtils.kexTokenAliasModel,
          ),
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
        txProcessLoadedState: expectedTxProcessLoadedState as TxProcessLoadedState,
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
