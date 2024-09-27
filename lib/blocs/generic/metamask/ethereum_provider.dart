import 'package:flutter_web3/flutter_web3.dart';

/// This file exists for ability to mock Ethereum
class EthereumProvider {
  const EthereumProvider();

  bool get isSupported => ethereum != null;

  void removeAllListeners() => ethereum?.removeAllListeners();

  void handleConnect(void Function(ConnectInfo) listener) => ethereum?.onConnect(listener);
  void handleDisconnect(void Function(ProviderRpcError) listener) => ethereum?.onDisconnect(listener);

  void handleAccountsChanged(void Function(List<String>) listener) => ethereum?.onAccountsChanged(listener);
  void handleChainChanged(void Function(int) listener) => ethereum?.onChainChanged(listener);

  Future<List<String>?> requestAccount() async => ethereum?.requestAccount();

  Future<int?> getChainId() async => ethereum?.getChainId();

  Future<void> switchWalletChain(int chainId) async => ethereum?.walletSwitchChain(chainId);
  Future<void> addWalletChain({
    required int chainId,
    required String rpcUrl,
    required String chainName,
    required String nativeCurrencyName,
    required String nativeCurrencySymbol,
    required int nativeCurrencyDecimals,
  }) async =>
      ethereum?.walletAddChain(
        chainId: chainId,
        rpcUrls: <String>[rpcUrl],
        chainName: chainName,
        nativeCurrency: CurrencyParams(
          name: nativeCurrencyName,
          symbol: nativeCurrencySymbol,
          decimals: nativeCurrencyDecimals,
        ),
      );
}
