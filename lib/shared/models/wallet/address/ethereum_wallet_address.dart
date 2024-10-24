import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart' show HexCodec;
import 'package:cryptography_utils/cryptography_utils.dart' hide ECPoint;
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32_pair.dart';
import 'package:miro/shared/utils/cryptography/keccak256.dart';
import 'package:pointycastle/pointycastle.dart' show ECDomainParameters, ECPoint;

class EthereumWalletAddress extends AWalletAddress {
  /// The length of a wallet address, including the '0x' prefix
  static const int addressLength = AWalletAddress.addressByteLength * 2 + 2;

  const EthereumWalletAddress({required Uint8List addressBytes}) : super(addressBytes: addressBytes);

  EthereumWalletAddress.fromString(String address)
      : assert(address.length == addressLength, 'Ethereum wallet address must be $addressLength characters, not ${address.length}'),
        super(addressBytes: HexCodec.decode(address));

  factory EthereumWalletAddress.fromBech32(String bech32Address) {
    final Bech32Pair bech32pair = Bech32.decode(bech32Address);
    return EthereumWalletAddress(addressBytes: bech32pair.data);
  }

  factory EthereumWalletAddress.fromPrivateKey(ECPrivateKey privateKey) {
    Uint8List publicKey = _getPublicKeyFromPrivateKey(privateKey.bytes);
    // Remove the first byte (0x04) for uncompressed public key
    publicKey = publicKey.sublist(1);
    assert(publicKey.length == 64, 'Invalid public key length. Must be 64 bytes, not ${publicKey.length}');

    Uint8List keccakHash = Keccak256.encode(publicKey);
    // Take the last 20 bytes for the address
    Uint8List ethereumBytes = keccakHash.sublist(keccakHash.length - 20);
    return EthereumWalletAddress(addressBytes: ethereumBytes);
  }

  factory EthereumWalletAddress.fromAnyType(String address) {
    try {
      return EthereumWalletAddress.fromBech32(address);
    } catch (e) {
      return EthereumWalletAddress.fromString(address);
    }
  }

  /// Returns the associated [address] as a Hash string.
  @override
  String get address => _toChecksumAddress(HexCodec.encode(addressBytes, includePrefixBool: true));

  @override
  WalletAddressType get type => WalletAddressType.ethereum;

  String toKiraAddress() {
    String hrp = globalLocator<NetworkModuleBloc>().tokenDefaultDenomModel.bech32AddressPrefix ?? '';
    return Bech32.encode(hrp, addressBytes);
  }

  /// Converts an Ethereum address to its checksummed version according to EIP-55
  String _toChecksumAddress(String address) {
    // Remove '0x' prefix if present and convert address to lowercase
    String addressLower = address.replaceFirst('0x', '').toLowerCase();

    // Compute the Keccak-256 hash of the lowercase address
    Uint8List hashedAddress = Keccak256.encode(utf8.encode(addressLower));

    // Apply checksum by adjusting the case of each character based on the hash
    StringBuffer checksumAddress = StringBuffer('0x');
    for (int i = 0; i < addressLower.length; i++) {
      int hashChar = int.parse(hashedAddress[i >> 1].toRadixString(16).padLeft(2, '0').substring(i % 2, i % 2 + 1), radix: 16);
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
