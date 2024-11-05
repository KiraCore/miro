import 'dart:convert';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart' hide ECSignature, ECPrivateKey, ECPoint;
import 'package:elliptic/elliptic.dart' hide PublicKey;
import 'package:flutter_web3/flutter_web3.dart' hide Signer;
import 'package:miro/shared/utils/cryptography/keccak256.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:ecdsa/ecdsa.dart';

import 'dart:convert';
import 'dart:typed_data';
// import 'package:convert/convert.dart';
// import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
// import 'package:pointycastle/ecc/ecc_fp.dart';
import 'package:pointycastle/export.dart';

// Function to generate a public key from a private key
Uint8List generatePublicKey(Uint8List privateKey) {
  final ECCurve_secp256k1 curve = ECCurve_secp256k1();
  final ECPoint G = curve.G;
  final BigInt d = BigInt.parse(HexCodec.encode(privateKey), radix: 16);
  final ECPoint? Q = G * d;
  final String xBytes = Q!.x!.toBigInteger()!.toRadixString(16).padLeft(64, '0');
  final String yBytes = Q.y!.toBigInteger()!.toRadixString(16).padLeft(64, '0');
  final String pubKeyHex = '04$xBytes$yBytes';
  return Uint8List.fromList(HexCodec.decode(pubKeyHex));
}

// Function to compress the public key
Uint8List compressPublicKey(Uint8List publicKey) {
  final Uint8List x = publicKey.sublist(1, 33);
  final BigInt y = BigInt.parse(HexCodec.encode(publicKey.sublist(33, 65)), radix: 16);
  final int prefix = (y.isEven) ? 0x02 : 0x03;
  return Uint8List.fromList(<int>[prefix, ...x]);
}

// Function to sign a message
Uint8List signMessage(Uint8List privateKey, Uint8List message) {
  final ECCurve_secp256k1 curve = ECCurve_secp256k1();
  final ECDomainParameters domainParams = ECDomainParameters('secp256k1');
  final ECPrivateKey keyParams = ECPrivateKey(BigInt.parse(HexCodec.encode(privateKey), radix: 16), domainParams);
  final Signer signer = Signer('SHA-256/ECDSA');
  signer.init(true, PrivateKeyParameter<ECPrivateKey>(keyParams));
  final ECSignature sig = signer.generateSignature(message) as ECSignature;
  final String r = sig.r.toRadixString(16).padLeft(64, '0');
  final String s = sig.s.toRadixString(16).padLeft(64, '0');
  return Uint8List.fromList(HexCodec.decode('$r$s'));
}

// // Helper: Convert bytes to BigInt
// BigInt bytesToBigInt(Uint8List bytes) {
//   return BigInt.parse(HexCodec.encode(bytes), radix: 16);
// }
//
// // Function to recover public key from MetaMask signature
// Uint8List? recoverPublicKeyFromSignature(String signature, Uint8List msgHash) {
//   final Uint8List sigBytes = HexCodec.decode(signature.substring(2)); // Remove 0x prefix
//
//   final BigInt r = bytesToBigInt(sigBytes.sublist(0, 32));
//   final BigInt s = bytesToBigInt(sigBytes.sublist(32, 64));
//   final int v = sigBytes[64] - 27; // Adjust v (Ethereum adds 27 to recovery id)
//
//   final EthSignature ecSignature = EthSignature.fromRS(r, s, v);
//
//   final PublicKey recoveredPoint = ecRecover(getSecp256k1(), ecSignature, msgHash); // Point recovery
//
//   // Encode the public key in uncompressed format (65 bytes)
//   final String xBytes = recoveredPoint.X.toRadixString(16).padLeft(64, '0');
//   final String yBytes = recoveredPoint.Y.toRadixString(16).padLeft(64, '0');
//   final String pubKeyHex = '04$xBytes$yBytes'; // Uncompressed key prefix is 0x04
//
//   print('Recovered Public Key (Hex): $pubKeyHex');
//
//   return Uint8List.fromList(HexCodec.decode(pubKeyHex));
// }
//
// // Keccak-256 hash function (Ethereum hashing)
// Uint8List keccakUtf8(String input) {
//   final Uint8List bytes = utf8.encode(input);
//   return Uint8List.fromList(Keccak256.encode(Uint8List.fromList(bytes)));
// }
//
// // Function to compress the 64-byte public key
// Uint8List compressPublicKey(Uint8List uncompressedKey) {
//   if (uncompressedKey.length != 64) {
//     throw Exception('Invalid uncompressed key length: ${uncompressedKey.length}');
//   }
//
//   // Split the 64-byte key into X (32 bytes) and Y (32 bytes)
//   final Uint8List x = uncompressedKey.sublist(0, 32);
//   final BigInt y = BigInt.parse(HexCodec.encode(uncompressedKey.sublist(32, 64)), radix: 16);
//
//   // Determine the prefix: 0x02 if Y is even, 0x03 if Y is odd
//   final int prefix = (y.isEven) ? 0x02 : 0x03;
//
//   // Combine the prefix and X-coordinate into the compressed key (33 bytes)
//   final Uint8List compressedKey = Uint8List(33);
//   compressedKey[0] = prefix;
//   compressedKey.setRange(1, 33, x);
//
//   return compressedKey;
// }

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

// Signing function: Requests personal_sign and recovers public key
  Future<Map<String, dynamic>?> signTransaction(String userAddress, Map<String, dynamic> transaction) async {
    // Replace with your Ethereum private key
    const String privateKeyHex = '.....';
    final Uint8List privateKey = Uint8List.fromList(HexCodec.decode(privateKeyHex));

    // Generate public key
    final Uint8List publicKey = generatePublicKey(privateKey);
    final Uint8List compressedPublicKey = compressPublicKey(publicKey);
    final String publicKeyBase64 = base64Encode(compressedPublicKey);
    print('Compressed Public Key (Base64): $publicKeyBase64');

    // // Create a transaction message
    // final transaction = {
    //   'msg': [
    //     {
    //       'type': 'cosmos-sdk/MsgSend',
    //       'value': {
    //         'from_address': cosmosAddress,
    //         'to_address': 'recipient_cosmos_address',
    //         'amount': [
    //           {'denom': 'atom', 'amount': '1000'}
    //         ]
    //       }
    //     }
    //   ],
    //   'fee': {
    //     'amount': [
    //       {'denom': 'atom', 'amount': '500'}
    //     ],
    //     'gas': '200000'
    //   },
    //   'memo': 'Test transaction',
    //   'chain_id': 'your-chain-id',
    //   'sequence': '1',
    //   'account_number': '123'
    // };

    // Sign the transaction
    final String transactionJson = jsonEncode(transaction);
    final Uint8List transactionBytes = utf8.encode(transactionJson);
    final Uint8List signature = signMessage(privateKey, Uint8List.fromList(transactionBytes));
    final String signatureBase64 = base64Encode(signature);
    print('Signature (Base64): $signatureBase64');

    // Build the signed transaction
    final Map<String, dynamic> signedTransaction = <String, dynamic>{
      'msg': transaction['msg'],
      'fee': transaction['fee'],
      'memo': transaction['memo'],
      'signatures': <Map<String, Object>>[
        <String, Object>{
          'pub_key': <String, String>{
            'type': 'tendermint/PubKeySecp256k1',
            'value': publicKeyBase64,
          },
          'signature': signatureBase64,
        }
      ]
    };

    // Convert the signed transaction to JSON
    final String signedTransactionJson = jsonEncode(signedTransaction);
    print('Signed Transaction JSON: $signedTransactionJson');
    return signedTransaction;

    // final Uint8List bytes = utf8.encode(jsonEncode(transaction));
    // final Uint8List msgHash = Keccak256.encode(Uint8List.fromList(bytes));
    // print('Message Hash: ${HexCodec.encode(msgHash)}');
    //
    // final String signature = await ethereum?.request(
    //   'personal_sign',
    //   <dynamic>[userAddress, '0x' + HexCodec.encode(msgHash)],
    // ) as String;
    //
    // try {
    //   final Uint8List? publicKey = recoverPublicKeyFromSignature(signature, msgHash);
    //   if (publicKey != null) {
    //     final String pubKeyBase64 = base64Encode(publicKey);
    //     print('Base64 Encoded Cosmos Public Key: $pubKeyBase64');
    //
    //     // Step 5: Build the signed Cosmos transaction
    //     final Uint8List formattedSignature = compressPublicKey(extractRSV(signature));
    //     print('length of signature: ${formattedSignature.length}');
    //     print('length of base signature:${base64Encode(formattedSignature).length} ${base64Encode(formattedSignature)}');
    //     return buildSignedCosmosTx(
    //       pubKeyBase64,
    //       base64Encode(formattedSignature),
    //       fee: transaction['fee'] as Map<String, dynamic>,
    //       msg: transaction['msg'] as List<Map<String, dynamic>>,
    //       r: HexCodec.decode(signature).sublist(0, 32).buffer.asByteData().getUint32(0),
    //       s: HexCodec.decode(signature).sublist(32, 64).buffer.asByteData().getUint32(0),
    //     );
    //     //
    //     // // Step 6: Broadcast the transaction
    //     // await broadcastTransaction(signedTx);
    //   } else {
    //     print('Failed to recover public key.');
    //   }
    // } catch (e) {
    //   print('Error: $e');
    // }
    // return null;
  }

  Uint8List extractRSV(String signature) {
    final Uint8List sigBytes = HexCodec.decode(signature);

    final Uint8List r = sigBytes.sublist(0, 32);
    final Uint8List s = sigBytes.sublist(32, 64);
    final int v = sigBytes[64]; // Recovery byte

    // Cosmos doesn’t need the `v` byte, only `r` and `s`.
    print('r: ${r.toString()}');
    print('s: ${s.toString()}');

    return Uint8List.fromList(<int>[...r, ...s]); // Combine r and s for Cosmos
  }

  Map<String, dynamic> buildSignedCosmosTx(
    String pubKeyBase64,
    String signatureBase64, {
    required Map<String, dynamic> fee,
    required List<Map<String, dynamic>> msg,
    required int r,
    required int s,
  }) {
    return <String, dynamic>{
      'msg': msg, // Your Cosmos transaction message
      'fee': fee, // Transaction fees
      'memo': 'Test transaction',
      'signatures': <Map<String, Object>>[
        <String, Object>{
          'pub_key': <String, String>{'type': 'cosmos.crypto.secp256k1.PubKey', 'value': pubKeyBase64},
          'signature': signatureBase64,
          'r': r,
          's': s,
        }
      ]
    };
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
}
