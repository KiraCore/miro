import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart' show HexCodec;
import 'package:cryptography_utils/cryptography_utils.dart' hide ECPoint;
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/utils/cryptography/keccak256.dart';
import 'package:pointycastle/pointycastle.dart' show ECDomainParameters, ECPoint;

class EthereumWalletAddress extends AWalletAddress {
  /// The length of a wallet address, including the '0x' prefix
  static const int addressLength = AWalletAddress.addressByteLength * 2 + 2;

  const EthereumWalletAddress({required Uint8List addressBytes}) : super(addressBytes: addressBytes);

  EthereumWalletAddress.fromString(String address)
      : assert(address.length == addressLength,
            'Ethereum wallet address must be $addressLength characters, not ${address.length}'),
        super(addressBytes: HexCodec.decode(address));

  factory EthereumWalletAddress.fromPrivateKey(ECPrivateKey privateKey) {
    Uint8List uncompressedPublicKey = _getPublicKeyFromPrivateKey(privateKey.bytes);
    return EthereumWalletAddress.fromUncompressedPublicKey(uncompressedPublicKey);
  }

  factory EthereumWalletAddress.fromUncompressedPublicKey(Uint8List uncompressedPublicKey) {
    // Remove the first byte (0x04)
    if (uncompressedPublicKey[0] == 0x04) {
      uncompressedPublicKey = uncompressedPublicKey.sublist(1);
    }
    assert(uncompressedPublicKey.length == 64,
        'Invalid public key length. Must be 64 bytes, not ${uncompressedPublicKey.length}');

    Uint8List keccakHash = Keccak256.encode(uncompressedPublicKey);
    // Take the last 20 bytes for the address
    Uint8List ethereumBytes = keccakHash.sublist(keccakHash.length - 20);
    return EthereumWalletAddress(addressBytes: ethereumBytes);
  }

  /// Returns the associated [address] as a Hash string.
  @override
  String get address => _toChecksumAddress(HexCodec.encode(addressBytes, includePrefixBool: true));

  @override
  WalletAddressType get type => WalletAddressType.ethereum;

  /// Converts an Ethereum address to its checksummed version according to EIP-55
  String _toChecksumAddress(String address) {
    // Remove '0x' prefix if present and convert address to lowercase
    String addressLower = address.replaceFirst('0x', '').toLowerCase();

    // Compute the Keccak-256 hash of the lowercase address
    Uint8List hashedAddress = Keccak256.encode(utf8.encode(addressLower));

    // Apply checksum by adjusting the case of each character based on the hash
    StringBuffer checksumAddress = StringBuffer('0x');
    for (int i = 0; i < addressLower.length; i++) {
      int hashChar =
          int.parse(hashedAddress[i >> 1].toRadixString(16).padLeft(2, '0').substring(i % 2, i % 2 + 1), radix: 16);
      if (hashChar >= 8) {
        checksumAddress.write(addressLower[i].toUpperCase());
      } else {
        checksumAddress.write(addressLower[i]);
      }
    }
    return checksumAddress.toString();
  }

  // TODO(Mykyta): the Secp256k1's function returns the wrong public key here -- Secp256k1.privateKeyBytesToPublic(privateKey.bytes);
  static Uint8List _getPublicKeyFromPrivateKey(Uint8List privateKey) {
    ECDomainParameters ecDomain = ECDomainParameters('secp256k1');
    BigInt privateKeyNum = BigInt.parse(HexCodec.encode(privateKey), radix: 16);
    ECPoint? ecPoint = ecDomain.G * privateKeyNum;
    Uint8List publicKey = ecPoint!.getEncoded(false); // Uncompressed public key
    return publicKey;
  }
}
