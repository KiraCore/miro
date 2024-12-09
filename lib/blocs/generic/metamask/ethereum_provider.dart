import 'dart:convert';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:cryptography_utils/cryptography_utils.dart' hide ECSignature;
import 'package:elliptic/elliptic.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/utils/cryptography/keccak256.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:codec_utils/codec_utils.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/ecc/api.dart' hide ECSignature;
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:bech32/bech32.dart' as bech32;

// Helper: Convert bytes to BigInt
BigInt bytesToBigInt(Uint8List bytes) {
  return BigInt.parse(HexCodec.encode(bytes), radix: 16);
}

// Function to recover public key from MetaMask signature
Uint8List? recoverPublicKeyFromSignature(String signature, Uint8List msgHash) {
  final Uint8List sigBytes = HexCodec.decode(signature.substring(2)); // Remove 0x prefix

  final BigInt r = bytesToBigInt(sigBytes.sublist(0, 32));
  final BigInt s = bytesToBigInt(sigBytes.sublist(32, 64));
  final int v = sigBytes[64] - 27; // Adjust v (Ethereum adds 27 to recovery id)

  final EthSignature ecSignature = EthSignature.fromRS(r, s, v);

  final PublicKey recoveredPoint = ecRecover(getSecp256k1(), ecSignature, msgHash); // Point recovery

  // Encode the public key in uncompressed format (65 bytes)
  final String xBytes = recoveredPoint.X.toRadixString(16).padLeft(64, '0');
  final String yBytes = recoveredPoint.Y.toRadixString(16).padLeft(64, '0');
  final String pubKeyHex = '04$xBytes$yBytes'; // Uncompressed key prefix is 0x04

  print('Recovered Public Key (Hex): $pubKeyHex');

  return Uint8List.fromList(HexCodec.decode(pubKeyHex));
}

// Keccak-256 hash function (Ethereum hashing)
Uint8List keccakUtf8(String input) {
  final Uint8List bytes = utf8.encode(input);
  return Uint8List.fromList(Keccak256.encode(Uint8List.fromList(bytes)));
}

// Function to compress the 64-byte public key
Uint8List compressPublicKey(Uint8List uncompressedKey) {
  if (uncompressedKey.length != 64) {
    throw Exception('Invalid uncompressed key length: ${uncompressedKey.length}');
  }

  // Split the 64-byte key into X (32 bytes) and Y (32 bytes)
  final Uint8List x = uncompressedKey.sublist(0, 32);
  final BigInt y = BigInt.parse(HexCodec.encode(uncompressedKey.sublist(32, 64)), radix: 16);

  // Determine the prefix: 0x02 if Y is even, 0x03 if Y is odd
  final int prefix = (y.isEven) ? 0x02 : 0x03;

  // Combine the prefix and X-coordinate into the compressed key (33 bytes)
  final Uint8List compressedKey = Uint8List(33);
  compressedKey[0] = prefix;
  compressedKey.setRange(1, 33, x);

  return compressedKey;
}

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

  Future<String?> getPublicKey(EthereumWalletAddress address) async => ethereum?.request(
    'eth_getEncryptionPublicKey',
    <String>[address.address],
  );

  Future<String?> signMessage(EthereumWalletAddress address, String message) async => ethereum?.request(
    'personal_sign',
    <String>[message, address.address],
  );


  /// Helper function to convert bits from one base to another
  Uint8List convertBits(Uint8List data, int fromBits, int toBits, {bool pad = true}) {
    int acc = 0;
    int bits = 0;
    int maxv = (1 << toBits) - 1;
    Uint8List result = Uint8List(0);

    for (int value in data) {
      if ((value >> fromBits) != 0) {
        throw ArgumentError('Invalid data for convertBits');
      }
      acc = (acc << fromBits) | value;
      bits += fromBits;
      while (bits >= toBits) {
        bits -= toBits;
        result = Uint8List.fromList(<int>[...result, (acc >> bits) & maxv]);
      }
    }

    if (pad) {
      if (bits > 0) {
        result = Uint8List.fromList(<int>[...result, (acc << (toBits - bits)) & maxv]);
      }
    } else if (bits >= fromBits || ((acc << (toBits - bits)) & maxv) != 0) {
      throw ArgumentError('Invalid padding in convertBits');
    }

    return result;
  }

  /// Converts an Ethereum public key to a Cosmos address
  String ethereumPublicKeyToCosmosAddress(Uint8List publicKey, String prefix) {
    // Step 1: Hash the public key with SHA-256
    Digest sha256Hash = sha256.convert(publicKey);

    // Step 2: Hash the SHA-256 output with RIPEMD-160
    Uint8List ripemd160Hash = RIPEMD160Digest().process(Uint8List.fromList(sha256Hash.bytes));

    // Step 3: Convert the RIPEMD-160 output to base32 words
    Uint8List words = convertBits(ripemd160Hash, 8, 5);

    // Step 4: Encode in Bech32 format with the Cosmos prefix
    return bech32.Bech32Encoder().convert(bech32.Bech32(prefix, words));
  }

  Future<void> getPublicKey() async {
    // Example Ethereum public key (uncompressed, 64 bytes)

    Uint8List ethPublicKey = Uint8List.fromList(<int>[
      0x04, // Prefix for uncompressed public key
      // X-coordinate (32 bytes)
      0x79, 0xbe, 0x66, 0x7e, 0xf9, 0xdc, 0xbb, 0xac,
      0x55, 0xa0, 0x62, 0x95, 0xce, 0x87, 0x0b, 0x07,
      0x02, 0x83, 0xab, 0x0d, 0xa2, 0xb4, 0x7b, 0x94,
      0x67, 0x49, 0x89, 0x92, 0x96, 0x4d, 0xd8, 0x70,
      // Y-coordinate (32 bytes)
      0x99, 0xc5, 0x77, 0x10, 0x9f, 0x93, 0xa5, 0x48,
      0x3c, 0x31, 0x68, 0x54, 0xfe, 0x24, 0x4c, 0xa1,
      0x63, 0x43, 0x56, 0x42, 0x56, 0x57, 0x81, 0xf1,
      0x38, 0x74, 0x34, 0xa3, 0x8b, 0x65, 0x6d, 0xf9
    ]);

    // final ethPK = await EthereumProvider().getPublicKey(EthereumWalletAddress.fromString('0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5'));
    print('pre Cosmos Address');
    final String? signature = await const EthereumProvider().signMessage(EthereumWalletAddress.fromString('0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5'), '123');

    try {
      print('pre Cosmos Address');
      final Uint8List bytes = utf8.encode(jsonEncode('test'));
      final Uint8List msgHash = Keccak256.encode(Uint8List.fromList(bytes));
      final Uint8List? publicKey = recoverPublicKeyFromSignature(signature!, msgHash);
      if (publicKey != null) {
        print('pre Cosmos Address');
        // Generate Cosmos address
        String cosmosAddress = ethereumPublicKeyToCosmosAddress(publicKey, 'kira');
        print('Cosmos Address: $cosmosAddress');
      } else {
        print('Failed to recover public key.');
      }
    } catch (e) {
      print('Error: $e');
    }
    return;
  }

// Function to recover public key from MetaMask signature
  Uint8List? recoverPublicKeyFromSignature(String signature, Uint8List msgHash) {
    final Uint8List sigBytes = HexCodec.decode(signature.substring(2)); // Remove 0x prefix

    final BigInt r = bytesToBigInt(sigBytes.sublist(0, 32));
    final BigInt s = bytesToBigInt(sigBytes.sublist(32, 64));
    final int v = sigBytes[64] - 27; // Adjust v (Ethereum adds 27 to recovery id)

    final EthSignature ecSignature = EthSignature.fromRS(r, s, v);

    final PublicKey recoveredPoint = ecRecover(getSecp256k1(), ecSignature, msgHash); // Point recovery

    // Encode the public key in uncompressed format (65 bytes)
    final String xBytes = recoveredPoint.X.toRadixString(16).padLeft(64, '0');
    final String yBytes = recoveredPoint.Y.toRadixString(16).padLeft(64, '0');
    final String pubKeyHex = '04$xBytes$yBytes'; // Uncompressed key prefix is 0x04

    print('Recovered Public Key (Hex): $pubKeyHex');

    return Uint8List.fromList(HexCodec.decode(pubKeyHex));
  }

  /// Converts a hex string representation of an Ethereum public key to bytes
  Uint8List ethereumPublicKeyFromHex(String publicKeyHex) {
    // Step 1: Remove the '0x' prefix if it exists
    if (publicKeyHex.startsWith('0x')) {
      publicKeyHex = publicKeyHex.substring(2);
    }

    // Step 2: Decode the hex string to bytes
    Uint8List publicKeyBytes = Uint8List.fromList(HexCodec.decode(publicKeyHex));

    // Step 3: Validate the length of the key
    if (publicKeyBytes.length != 65 && publicKeyBytes.length != 33) {
      throw ArgumentError('Invalid public key length: Expected 65 bytes (uncompressed) or 33 bytes (compressed), but got ${publicKeyBytes.length} bytes.');
    }

    return publicKeyBytes;
  }


// Signing function: Requests personal_sign and recovers public key
  Future<Map<String, dynamic>?> signTransaction(String userAddress, Map<String, dynamic> transaction) async {
    final Uint8List bytes = utf8.encode(jsonEncode(transaction));
    final Uint8List msgHash = Keccak256.encode(Uint8List.fromList(bytes));
    print('Message Hash: ${HexCodec.encode(msgHash)}');

    final String signature = await ethereum?.request(
      'personal_sign',
      <dynamic>[userAddress, '0x' + HexCodec.encode(msgHash)],
    ) as String;

    try {
      final Uint8List? publicKey = recoverPublicKeyFromSignature(signature, msgHash);
      if (publicKey != null) {
        final String pubKeyBase64 = base64Encode(publicKey);
        print('Base64 Encoded Cosmos Public Key: $pubKeyBase64');

        // Step 5: Build the signed Cosmos transaction
        final Uint8List formattedSignature = compressPublicKey(extractRSV(signature));
        print('length of signature: ${formattedSignature.length}');
        print('length of base signature:${base64Encode(formattedSignature).length} ${base64Encode(formattedSignature)}');
        return buildSignedCosmosTx(
          pubKeyBase64,
          base64Encode(formattedSignature),
          fee: transaction['fee'] as Map<String, dynamic>,
          msg: transaction['msg'] as List<Map<String, dynamic>>,
          r: HexCodec.decode(signature).sublist(0, 32).buffer.asByteData().getUint32(0),
          s: HexCodec.decode(signature).sublist(32, 64).buffer.asByteData().getUint32(0),
        );
        //
        // // Step 6: Broadcast the transaction
        // await broadcastTransaction(signedTx);
      } else {
        print('Failed to recover public key.');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
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
