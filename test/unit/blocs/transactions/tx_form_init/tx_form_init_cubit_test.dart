import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/a_tx_form_init_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/states/tx_form_init_downloading_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/states/tx_form_init_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/states/tx_form_init_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/tx_form_init_cubit.dart';
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
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/transactions/tx_form_init/tx_form_init_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  NetworkModuleBloc actualNetworkModuleBloc = globalLocator<NetworkModuleBloc>();
  WalletProvider walletProvider = globalLocator<WalletProvider>();

  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
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
      interxVersion: 'v0.4.20-rc2',
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

  group('Tests of TxFormInitCubit process', () {
    test('Should emit certain states when network is online while downloading fee', () async {
      // Arrange
      TxFormInitCubit actualTxFormInitCubit = TxFormInitCubit(txMsgType: TxMsgType.msgSend);

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(healthyNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkHealthyModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Assert
      ATxFormInitState expectedTxFormInitState = TxFormInitDownloadingState();

      TestUtils.printInfo('Should return TxFormInitDownloadingState as initial state');
      expect(actualTxFormInitCubit.state, expectedTxFormInitState);

      // ************************************************************************************************

      // Act
      await actualTxFormInitCubit.downloadTxFee();

      // Assert
      expectedTxFormInitState = TxFormInitLoadedState(feeTokenAmountModel: feeTokenAmountModel);

      TestUtils.printInfo('Should return TxFormInitLoadedState with feeTokenAmountModel');
      expect(actualTxFormInitCubit.state, expectedTxFormInitState);

      // ************************************************************************************************
    });

    test('Should emit certain states when network is offline while downloading fee', () async {
      // Arrange
      TxFormInitCubit actualTxFormInitCubit = TxFormInitCubit(txMsgType: TxMsgType.msgSend);

      // Act
      actualNetworkModuleBloc.add(NetworkModuleAutoConnectEvent(offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState.connected with NetworkOfflineModel');
      expect(actualNetworkModuleBloc.state, expectedNetworkModuleState);

      // ************************************************************************************************

      // Assert
      ATxFormInitState expectedTxFormInitState = TxFormInitDownloadingState();

      TestUtils.printInfo('Should return TxFormInitDownloadingState as initial state');
      expect(actualTxFormInitCubit.state, expectedTxFormInitState);

      // ************************************************************************************************

      // Act
      await actualTxFormInitCubit.downloadTxFee();

      // Assert
      expectedTxFormInitState = TxFormInitErrorState();

      TestUtils.printInfo('Should return TxFormInitErrorState if cannot fetch fee for transaction');
      expect(actualTxFormInitCubit.state, expectedTxFormInitState);

      // ************************************************************************************************
    });
  });
}
