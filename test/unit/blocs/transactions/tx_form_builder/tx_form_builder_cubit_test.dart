import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/states/tx_form_builder_empty_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
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
// fvm flutter test test/unit/blocs/transactions/tx_form_builder/tx_form_builder_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMockLocator();

  NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
  AuthCubit authCubit = globalLocator<AuthCubit>();

  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);

  final Mnemonic recipientMnemonic = Mnemonic(value: 'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
  final Wallet recipientWallet = Wallet.derive(mnemonic: recipientMnemonic);
  // @formatter:on

  await authCubit.signIn(senderWallet);

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

  TokenAliasModel tokenAliasModel = const TokenAliasModel(
    name: 'Kira',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.parse('100'),
    tokenAliasModel: tokenAliasModel,
  );

  TokenAmountModel txTokenAmountModel = TokenAmountModel(
    tokenAliasModel: tokenAliasModel,
    lowestDenominationAmount: Decimal.fromInt(300),
  );

  TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
    memo: '',
    feeTokenAmountModel: TokenAmountModel(
      tokenAliasModel: tokenAliasModel,
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

  group('Tests of TxFormBuilderCubit process', () {
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
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(healthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkHealthyModel);

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
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkOfflineModel);

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
