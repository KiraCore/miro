import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:eth_sig_util/model/ecdsa_signature.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32.dart';
import 'package:miro/shared/utils/cryptography/keccak256.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

import 'package:pointycastle/digests/ripemd160.dart';
import 'package:secp256k1/secp256k1.dart';

class EthereumSignatureDecodeResult {
  final String compressedPublicKey;
  final String ethAddress;
  final String cosmosAddress;

  const EthereumSignatureDecodeResult({
    required this.compressedPublicKey,
    required this.ethAddress,
    required this.cosmosAddress,
  });

  factory EthereumSignatureDecodeResult.fromDataJson(Map<String, Object?> dataJson, {required String ethAddress}) =>
      EthereumSignatureDecodeResult(
        compressedPublicKey: dataJson['compressed_hex_public_key'] as String,
        cosmosAddress: dataJson['kira_address'] as String,
        ethAddress: ethAddress,
      );

  Map<String, Object?> toDataJson() => <String, Object?>{
        'compressed_hex_public_key': compressedPublicKey,
        'kira_address': cosmosAddress,
      };
}

/// This file exists for ability to mock Ethereum
class EthereumProvider {
  const EthereumProvider();

  static const String hiveBoxName = 'Ethereum';

  bool get isSupported => ethereum != null;

  void removeAllListeners() => ethereum?.removeAllListeners();

  void handleConnect(void Function(ConnectInfo) listener) => ethereum?.onConnect(listener);
  void handleDisconnect(void Function(ProviderRpcError) listener) => ethereum?.onDisconnect(listener);

  void handleAccountsChanged(void Function(List<String>) listener) => ethereum?.onAccountsChanged(listener);
  void handleChainChanged(void Function(int) listener) => ethereum?.onChainChanged(listener);

  Future<List<String>?> requestAccount() async => ethereum?.requestAccount();

  Future<int?> getChainId() async => ethereum?.getChainId();

  Future<String?> getPublicKey(String address) async => ethereum?.request(
        'eth_getEncryptionPublicKey',
        <String>[address],
      );

  Future<String?> signMessage(String address, String message) async {
    final String hexMessage = HexCodec.encode(utf8.encode(message));
    return ethereum?.request(
      'personal_sign',
      <String>[hexMessage, address],
    );
  }

  Future<EthereumSignatureDecodeResult?> decodeEthereumSignature({
    required String message,
    required String signatureHex,
    required String ethereumAddress,
    required String bech32Hrp,
  }) async {
    try {
      Uint8List? uncompressedPublicKey = _recoverPublicKey(message, signatureHex);

      String ethAddress = EthereumWalletAddress.fromUncompressedPublicKey(uncompressedPublicKey).address;
      if (ethAddress.toLowerCase() != ethereumAddress.toLowerCase()) {
        throw Exception('Ethereum address from the signature $ethAddress does not match the address $ethereumAddress');
      }

      Uint8List? compressedPublicKey = compressPublicKey(uncompressedPublicKey);
      String cosmosAddress = convertPublicKeyToCosmosAddress(compressedPublicKey, bech32Hrp);

      String publicKeyString = HexCodec.encode(compressedPublicKey);

      AppLogger().log(message: 'Decoded public key: $publicKeyString', logLevel: LogLevel.debug);
      AppLogger().log(message: 'Decoded Ethereum address: $ethAddress', logLevel: LogLevel.debug);
      AppLogger().log(message: 'Decoded Cosmos address: $cosmosAddress', logLevel: LogLevel.debug);

      return EthereumSignatureDecodeResult(
        compressedPublicKey: publicKeyString,
        ethAddress: ethAddress,
        cosmosAddress: cosmosAddress,
      );
    } catch (error) {
      AppLogger().log(message: 'Error decoding message: $error', logLevel: LogLevel.error);
      return null;
    }
  }

  Uint8List compressPublicKey(Uint8List uncompressedPublicKey) {
    PublicKey publicKey = PublicKey.fromHex('04${HexCodec.encode(uncompressedPublicKey)}');

    String compressedPublicKey = publicKey.toCompressedHex();
    return HexCodec.decode(compressedPublicKey);
  }

  String convertPublicKeyToCosmosAddress(Uint8List publicKey, String humanReadablePart) {
    // Hash the public key with SHA-256
    Digest sha256Hash = sha256.convert(publicKey);

    // Hash the SHA-256 output with RIPEMD-160
    Uint8List ripemd160Hash = RIPEMD160Digest().process(Uint8List.fromList(sha256Hash.bytes));

    return Bech32.encode(humanReadablePart, ripemd160Hash);
  }

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

  Uint8List _recoverPublicKey(String message, String signatureHex) {
    // Decode the signature
    Uint8List signature = HexCodec.decode(signatureHex);

    // Extract r, s, and v from the signature
    BigInt r = _bytesToBigInt(signature.sublist(0, 32));
    BigInt s = _bytesToBigInt(signature.sublist(32, 64));
    int v = signature[64];
    // NOTE: No need to adjust v value (-27), it will be done in ECDSASignature object
    // if (v >= 27) {
    //   v -= 27;
    // }

    ECDSASignature ecSignature = ECDSASignature(r, s, v);

    // Hash the message
    Uint8List messageBytes = utf8.encode(message);
    String prefix = '\x19Ethereum Signed Message:\n${messageBytes.length}';
    Uint8List prefixBytes = utf8.encode(prefix);
    Uint8List prefixedMessage = Uint8List.fromList(prefixBytes + messageBytes);
    Uint8List messageHash = Keccak256.encode(prefixedMessage);

    // Recover the public key
    Uint8List? uncompressedPublicKey = SignatureUtil.recoverPublicKeyFromSignature(ecSignature, messageHash);

    if (uncompressedPublicKey == null) {
      throw Exception('Failed to recover public key from signature.');
    }
    return uncompressedPublicKey;
  }

  BigInt _bytesToBigInt(Uint8List bytes) {
    return BigInt.parse(HexCodec.encode(bytes), radix: 16);
  }
}
