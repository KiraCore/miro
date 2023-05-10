import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_empty_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/msg_send/msg_send_form_controller.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/transactions/tx_form_builder_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMockLocator();

  NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
  AuthCubit authCubit = globalLocator<AuthCubit>();

  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(
      value:
          'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);

  final Mnemonic recipientMnemonic = Mnemonic(
      value:
          'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
  final Wallet recipientWallet = Wallet.derive(mnemonic: recipientMnemonic);
  // @formatter:on

  await authCubit.signIn(senderWallet);

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.parse('100'),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  TokenAmountModel txTokenAmountModel = TokenAmountModel(
    tokenAliasModel: TestUtils.kexTokenAliasModel,
    lowestDenominationAmount: Decimal.fromInt(300),
  );

  TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
    memo: '',
    feeTokenAmountModel: TokenAmountModel(
      tokenAliasModel: TestUtils.kexTokenAliasModel,
      lowestDenominationAmount: Decimal.fromInt(100),
    ),
    txMsgModel: MsgSendModel(
      fromWalletAddress: senderWallet.address,
      toWalletAddress: recipientWallet.address,
      tokenAmountModel: txTokenAmountModel,
    ),
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
    test('Should emit certain states when network is online while building UnsignedTxModel', () async {
      // Arrange
      MsgSendFormController actualMsgSendFormController = MsgSendFormController();
      TxFormBuilderCubit actualTxFormBuilderCubit = TxFormBuilderCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        msgFormController: actualMsgSendFormController,
      );

      // Assert
      ATxFormBuilderState expectedTxFormBuilderState = TxFormBuilderEmptyState();

      TestUtils.printInfo('Should return TxFormBuilderEmptyState as initial state');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.healthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkHealthyModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if UnsignedTxModel cannot be built');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMsgSendFormController.senderWalletAddress = senderWallet.address;

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if UnsignedTxModel cannot be built');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMsgSendFormController.recipientWalletAddress = recipientWallet.address;

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if UnsignedTxModel cannot be built');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMsgSendFormController.tokenAmountModel = txTokenAmountModel;
      UnsignedTxModel actualUnsignedTxModel = await actualTxFormBuilderCubit.buildUnsignedTx();

      // Assert
      TestUtils.printInfo('Should return unsignedTxModel MsgFormController is filled');
      expect(actualUnsignedTxModel, unsignedTxModel);

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderEmptyState();

      TestUtils.printInfo('Should return TxFormBuilderEmptyState after successful UnsignedTxModel build');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);
    });

    test('Should emit certain states when network is offline while building UnsignedTxModel', () async {
      // Arrange
      MsgSendFormController actualMsgSendFormController = MsgSendFormController();
      TxFormBuilderCubit actualTxFormBuilderCubit = TxFormBuilderCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        msgFormController: actualMsgSendFormController,
      );

      // Assert
      ATxFormBuilderState expectedTxFormBuilderState = TxFormBuilderEmptyState();

      TestUtils.printInfo('Should return TxFormBuilderEmptyState as initial state');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkOfflineModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if UnsignedTxModel cannot be built');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMsgSendFormController.senderWalletAddress = senderWallet.address;

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if UnsignedTxModel cannot be built');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMsgSendFormController.recipientWalletAddress = recipientWallet.address;

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if UnsignedTxModel cannot be built');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);

      // ************************************************************************************************

      // Act
      actualMsgSendFormController.tokenAmountModel = txTokenAmountModel;

      // Assert
      TestUtils.printInfo('Should throw exception if UnsignedTxModel cannot be built');
      expect(
        () => actualTxFormBuilderCubit.buildUnsignedTx(),
        throwsA(isA<Exception>()),
      );

      // ************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedTxFormBuilderState = TxFormBuilderErrorState();

      TestUtils.printInfo('Should return TxFormBuilderErrorState if MsgFormController is filled but network is offline');
      expect(actualTxFormBuilderCubit.state, expectedTxFormBuilderState);
    });
  });
}
