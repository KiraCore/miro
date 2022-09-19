import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/a_tx_send_form_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_building_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_init_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/tx_send_form_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
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
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/transactions/tx_send_form/tx_send_form_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
  WalletProvider walletProvider = globalLocator<WalletProvider>();

  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(
      value:
          'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);
  // @formatter:on

  walletProvider.updateWallet(senderWallet);

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
      interxVersion: 'v0.4.11',
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

  TokenAliasModel defaultFeeTokenAliasModel = const TokenAliasModel(
    name: 'Kira',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.parse('100'),
    tokenAliasModel: defaultFeeTokenAliasModel,
  );

  TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
    memo: 'Test memo',
    feeTokenAmountModel: TokenAmountModel(
      tokenAliasModel: defaultFeeTokenAliasModel,
      lowestDenominationAmount: Decimal.fromInt(100),
    ),
    txMsgModel: MsgSendModel(
      fromWalletAddress: senderWallet.address,
      toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
      tokenAmountModel: TokenAmountModel(
        tokenAliasModel: defaultFeeTokenAliasModel,
        lowestDenominationAmount: Decimal.fromInt(300),
      ),
    ),
  );

  group('Tests of TxSendFormCubit process', () {
    test('Should emit certain states when network is online while downloading fee and online while building UnsignedTxModel', () async {
      // Arrange
      TxSendFormCubit actualTxSendFormCubit = TxSendFormCubit();

      // Assert
      ATxSendFormState expectedTxSendFormState = TxSendFormInitState();

      TestUtils.printInfo('Should return TxSendFormInitState as initial state');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);

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
      await actualTxSendFormCubit.loadTxFee();

      // Assert
      expectedTxSendFormState = TxSendFormLoadedState(feeTokenAmountModel: feeTokenAmountModel);

      TestUtils.printInfo('Should return TxSendFormLoadedState with feeTokenAmountModel');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);

      // ************************************************************************************************

      // Act
      UnsignedTxModel? actualUnsignedTxModel = await actualTxSendFormCubit.buildTx(txLocalInfoModel);

      // Assert
      UnsignedTxModel expectedUnsignedTxModel = UnsignedTxModel(
        txLocalInfoModel: txLocalInfoModel,
        txRemoteInfoModel: const TxRemoteInfoModel(chainId: 'testnet-9', accountNumber: '669', sequence: '106'),
      );

      TestUtils.printInfo('Should return UnsignedTxModel with TxRemoteInfoModel');
      expect(actualUnsignedTxModel, expectedUnsignedTxModel);
    });

    test('Should emit certain states when network is offline while downloading fee', () async {
      // Arrange
      TxSendFormCubit actualTxSendFormCubit = TxSendFormCubit();

      // Assert
      ATxSendFormState expectedTxSendFormState = TxSendFormInitState();

      TestUtils.printInfo('Should return TxSendFormInitState as initial state');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);

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
      await actualTxSendFormCubit.loadTxFee();

      // Assert
      expectedTxSendFormState = TxSendFormErrorState();

      TestUtils.printInfo('Should return TxSendFormErrorState if cannot download initial transaction data');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);
    });

    test('Should emit certain states when network is online while downloading fee but offline while building UnsignedTxModel', () async {
      // Arrange
      TxSendFormCubit actualTxSendFormCubit = TxSendFormCubit();

      // Assert
      ATxSendFormState expectedTxSendFormState = TxSendFormInitState();

      TestUtils.printInfo('Should return TxSendFormInitState as initial state');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);

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
      await actualTxSendFormCubit.loadTxFee();

      // Assert
      expectedTxSendFormState = TxSendFormLoadedState(feeTokenAmountModel: feeTokenAmountModel);

      TestUtils.printInfo('Should return TxSendFormLoadedState with feeTokenAmountModel');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);

      // ************************************************************************************************

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkOfflineModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Act
      UnsignedTxModel? actualUnsignedTxModel = await actualTxSendFormCubit.buildTx(txLocalInfoModel);

      // Assert
      TestUtils.printInfo('Should return null if cannot build UnsignedTxModel');
      expect(actualUnsignedTxModel, null);

      // Assert
      expectedTxSendFormState = TxSendFormBuildingErrorState(feeTokenAmountModel: feeTokenAmountModel);

      TestUtils.printInfo('Should return TxSendFormBuildingErrorState if network offline when calling buildTx');
      expect(actualTxSendFormCubit.state, expectedTxSendFormState);
    });
  });
}
