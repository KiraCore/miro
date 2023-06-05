import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_empty_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'mock_data/mock_msg_form_model.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/transactions/tx_form_builder_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  AuthCubit authCubit = globalLocator<AuthCubit>();

  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);
  // @formatter:on

  await authCubit.signIn(senderWallet);

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.parse('100'),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
    memo: '',
    feeTokenAmountModel: TokenAmountModel(
      tokenAliasModel: TestUtils.kexTokenAliasModel,
      lowestDenominationAmount: Decimal.fromInt(100),
    ),
    txMsgModel: MockMsgFormModel.mockTxMsgModel,
  );

  TxRemoteInfoModel txRemoteInfoModel = const TxRemoteInfoModel(
    accountNumber: '669',
    chainId: 'testnet-9',
    sequence: '106',
  );

  UnsignedTxModel unsignedTxModel = UnsignedTxModel(
    txLocalInfoModel: txLocalInfoModel,
    txRemoteInfoModel: txRemoteInfoModel,
  );

  group('Tests of [TxFormBuilderCubit] process', () {
    test('Should emit certain states when [network ONLINE] while building UnsignedTxModel', () async {
      // Arrange
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      MockMsgFormModel actualMockMsgFormModel = MockMsgFormModel();
      TxFormBuilderCubit actualTxFormBuilderCubit = TxFormBuilderCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        msgFormModel: actualMockMsgFormModel,
      );

      // Assert
      ATxFormBuilderState expectedTxFormBuilderState = TxFormBuilderEmptyState();

      TestUtils.printInfo('Should [return TxFormBuilderEmptyState] as initial state');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Assert
      TestUtils.printInfo('Should [throw Exception] if [ALL required fields EMPTY] (UnsignedTxModel cannot be built)');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should [return TxFormBuilderErrorState] if [ALL required fields EMPTY] (UnsignedTxModel cannot be built)');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMockMsgFormModel.requiredField = 'REQUIRED_VALUE';
      // Act
      UnsignedTxModel actualUnsignedTxModel = await actualTxFormBuilderCubit.buildUnsignedTx();

      TestUtils.printInfo('Should [return UnsignedTxModel] if [ALL required fields FILLED] (UnsignedTxModel built successfully)');
      expect(actualUnsignedTxModel, unsignedTxModel);

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderEmptyState();

      TestUtils.printInfo('Should [return TxFormBuilderEmptyState] if [ALL required fields FILLED] (UnsignedTxModel built successfully)');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);
    });

    test('Should emit certain states when [network OFFLINE] while building UnsignedTxModel', () async {
      // Arrange
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://offline.kira.network/'));
      MockMsgFormModel actualMockMsgFormModel = MockMsgFormModel();
      TxFormBuilderCubit actualTxFormBuilderCubit = TxFormBuilderCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        msgFormModel: actualMockMsgFormModel,
      );

      // Assert
      ATxFormBuilderState expectedTxFormBuilderState = TxFormBuilderEmptyState();

      TestUtils.printInfo('Should [return TxFormBuilderEmptyState] as initial state');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Assert
      TestUtils.printInfo('Should [throw Exception] if [ALL required fields EMPTY] (UnsignedTxModel cannot be built)');
      expect(
            () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should [return TxFormBuilderErrorState] if [ALL required fields EMPTY] (UnsignedTxModel cannot be built)');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMockMsgFormModel.requiredField = 'REQUIRED_VALUE';

      // Assert
      TestUtils.printInfo('Should [throw Exception] if [ALL required fields FILLED] but [network OFFLINE] (UnsignedTxModel cannot be built)');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should [return TxFormBuilderErrorState] if [ALL required fields FILLED] but [network OFFLINE] (UnsignedTxModel cannot be built)');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);
    });
  });
}
