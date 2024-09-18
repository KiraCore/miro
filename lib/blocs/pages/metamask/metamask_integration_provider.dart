import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  String? currentAddress;

  int? currentChain;

  bool get isEnabled => ethereum != null;

  bool get isConnected => isEnabled && currentAddress != null;

  Future<void> connect() async {
    if (isEnabled) {
      final List<String> accounts = await ethereum!.requestAccount();
      print(accounts);
      if (accounts.isNotEmpty) {
        currentAddress = accounts.first;
      }

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  Future<void> pay() async {
    if (isConnected) {
      await ethereum!.request(
        'eth_sendTransaction',
        <Map<String, String>>[
          <String, String>{
            'to': '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5',
            // TODO(mykyta): parse kira's net
            'from': currentAddress!,
            'gas': '0x76c0',
            'value': '0x8ac7230489e80000',
            'data': '0x',
            'gasPrice': '0x4a817c800',
          },
        ],
      );
    }
  }

  void clear() {
    currentAddress = null;
    currentChain = null;
    notifyListeners();
  }

  void init() {
    if (isEnabled) {
      ethereum!.onMessage((String type, dynamic data) {
        print('onMessage');
        print(type);
        print(data);
      });

      ethereum!.removeAllListeners('accountsChanged');
      ethereum!.removeAllListeners('chainChanged');

      ethereum!.onAccountsChanged(_onAccountsChanged);
      ethereum!.onChainChanged(_onChainChanged);
    }
  }

  void _onAccountsChanged(List<String> accounts) {
    clear();
  }

  void _onChainChanged(int chain) {
    // TODO(Mykyta): .
  }

  @override
  void dispose() {
    ethereum?.removeAllListeners();
    currentAddress = null;
    currentChain = null;
    super.dispose();
  }
}
