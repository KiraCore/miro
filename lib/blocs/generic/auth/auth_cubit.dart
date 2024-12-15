import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/metamask/ethereum_provider.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/shared/controllers/global_nav/global_nav_controller.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/extensions/list_extension.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

class AuthCubit extends Cubit<Wallet?> {
  final IdentityRegistrarCubit _identityRegistrarCubit;
  final EthereumProvider _ethereumProvider;
  final ICacheManager _cacheManager;

  WalletAddressType? _loggedInWithAddressType;

  final Map<EthereumWalletAddress, CosmosWalletAddress> _cachedEthAddresses =
      <EthereumWalletAddress, CosmosWalletAddress>{};

  AuthCubit()
      : _identityRegistrarCubit = globalLocator<IdentityRegistrarCubit>(),
        _ethereumProvider = globalLocator<EthereumProvider>(),
        _cacheManager = globalLocator<ICacheManager>(),
        super(null);

  // TODO(Mykyta): move field to the State in the next PR. Won't do right now, because it'll affect a lot of pages
  WalletAddressType? get loggedInWithAddressType => _loggedInWithAddressType;

  bool get isEthereumSession => loggedInWithAddressType == WalletAddressType.ethereum;

  /// Only KIRA address can be used as identity (for Balances / Transactions / etc.)
  CosmosWalletAddress? get identityStateAddress {
    if (state == null) {
      return null;
    }
    if (state!.isEthereum) {
      return _cachedEthAddresses[state!.address as EthereumWalletAddress];
    }
    return state!.address as CosmosWalletAddress;
  }

  bool get isSignedIn => state != null;

  /// If [defaultAddressIsKiraBool] is `true`, the address type of the passed [wallet] will be changed to `KIRA`.
  /// If [defaultAddressIsKiraBool] is `false`, the address type of the passed [wallet] won't be changed.
  Future<void> signIn(Wallet wallet, {bool defaultAddressIsKiraBool = true}) async {
    if (wallet.isEthereum) {
      CosmosWalletAddress? bech32Address = _cachedEthAddresses[wallet.address] ??
          await _cacheCosmosAddressFromEthereum(
            wallet.address as EthereumWalletAddress,
            ecPrivateKey: wallet.ecPrivateKey,
            bech32Hrp: 'kira', // TODO(Mykyta): get from config. And in other places
          );

      await _identityRegistrarCubit.setWalletAddress(bech32Address);
      if (bech32Address == null) {
        _loggedInWithAddressType = null;
        emit(null);
        return;
      }
      if (defaultAddressIsKiraBool || state?.address is CosmosWalletAddress) {
        _loggedInWithAddressType = wallet.address.type;
        emit(Wallet(address: bech32Address));
        return;
      }
    } else {
      await _identityRegistrarCubit.setWalletAddress(wallet.address as CosmosWalletAddress);
    }
    _loggedInWithAddressType = wallet.address.type;
    emit(wallet);
  }

  Future<void> signOut() async {
    _loggedInWithAddressType = null;
    emit(null);
    await _identityRegistrarCubit.setWalletAddress(null);
    globalLocator<GlobalNavController>().leaveProtectedPage();
  }

  /// Returns the opposite address type (Ethereum -> Cosmos, Cosmos -> Ethereum)
  AWalletAddress? tryFindOppositeAddress(AWalletAddress address) {
    if (state == null || loggedInWithAddressType == WalletAddressType.cosmos) {
      return null;
    }
    if (address is EthereumWalletAddress) {
      return _cachedEthAddresses[address];
    } else if (address is CosmosWalletAddress) {
      return _cachedEthAddresses.keys.firstWhereOrNull(
        (EthereumWalletAddress a) => _cachedEthAddresses[a] == address,
      );
    }
    throw UnsupportedError('Type of address is not supported - $runtimeType');
  }

  /// String might have wallet address inside. If so, it will be replaced with a new type of the address if needed.
  /// It can change several addresses in one string with provided delimiter.
  ///
  /// Example:
  /// ```
  /// // If current address type is `Kira` during `Ethereum session`, and the passed string is `Ethereum`:
  /// final result = replaceAddressTypeIfExists('0x1234567890...');
  /// print(result); // 'kira1abcdefgh...'
  ///
  /// // If current address type is `Kira` during `Ethereum session`, and the passed string with several addresses of `Ethereum`:
  /// final result = replaceAddressTypeIfExists('0x1234567890... 0x13333333...');
  /// print(result); // 'kira1abcdefgh... kira1aaaaaaaa...'
  ///
  /// // If current address type is `Ethereum`, and the passed string is `Ethereum`:
  /// final result = replaceAddressTypeIfExists('0x1234567890...');
  /// print(result); // '0x1234567890...'
  /// ```
  String replaceAddressTypeIfExists(String address, {String delimiter = ' '}) {
    if (state == null ||
        loggedInWithAddressType == WalletAddressType.cosmos ||
        (address.contains('0x') == false && address.contains('kira') == false)) {
      return address;
    }
    return address.split(delimiter).map((String word) {
      switch (state!.address.type) {
        case WalletAddressType.cosmos:
          if (word.length == EthereumWalletAddress.addressLength && word.substring(0, 2) == '0x') {
            EthereumWalletAddress? key = _cachedEthAddresses.keys.firstWhereOrNull(
              (EthereumWalletAddress address) => address.address.toLowerCase() == word.toLowerCase(),
            );
            if (key != null) {
              return _cachedEthAddresses[key]!.address;
            }
          }
        case WalletAddressType.ethereum:
          if (word.length == CosmosWalletAddress.addressLengthWithoutHrp + 'kira'.length &&
              word.substring(0, 4) == 'kira') {
            CosmosWalletAddress? value = _cachedEthAddresses.values.firstWhereOrNull(
              (CosmosWalletAddress address) => address.address == word,
            );
            if (value != null) {
              return _cachedEthAddresses.keys
                  .firstWhereOrNull(
                    (EthereumWalletAddress address) => _cachedEthAddresses[address]!.address == word,
                  )!
                  .address;
            }
          }
      }
      return word;
    }).join(delimiter);
  }

  void toggleWalletAddress() {
    AWalletAddress? address = _toOppositeAddressType();
    if (address != null) {
      emit(Wallet(
        address: address,
        ecPrivateKey: state!.ecPrivateKey,
      ));
    }
  }

  Future<CosmosWalletAddress?> _cacheCosmosAddressFromEthereum(
    EthereumWalletAddress ethereumAddress, {
    required String bech32Hrp,
    ECPrivateKey? ecPrivateKey,
  }) async {
    String? kiraAddress = (json.decode(_cacheManager.get<String>(
      boxName: EthereumProvider.hiveBoxName,
      key: ethereumAddress.address.toLowerCase(),
      defaultValue: '{}',
    )) as Map<String, Object?>)['kira_address'] as String?;
    if (kiraAddress != null) {
      CosmosWalletAddress cosmosWalletAddress = CosmosWalletAddress.fromBech32(kiraAddress);
      _cachedEthAddresses[ethereumAddress] = cosmosWalletAddress;
      return cosmosWalletAddress;
    }

    // NOTE: must not be empty
    String dumbMessage = 'Signature for accessing the public key';
    try {
      String? compressedHexPublicKey;
      CosmosWalletAddress? cosmosAddress;
      if (ecPrivateKey != null) {
        // Get the public key from private key
        Uint8List ethPublicKey = ecPrivateKey.ecPublicKey.compressed;
        compressedHexPublicKey = HexCodec.encode(ethPublicKey);
        cosmosAddress = CosmosWalletAddress.fromEthereum(ethPublicKey);
      } else {
        // WARNING: Signature and decoding of that are heavy operations together and will freeze the UI if user didn't declined it
        // TODO(Mykyta): Move Signature and Decoding to web workers

        // Get the public key from Metamask's signature
        String? signature = await _ethereumProvider.signMessage(ethereumAddress.address, dumbMessage);
        if (signature == null) {
          throw Exception('Invalid signature for address ${ethereumAddress.address}');
        }
        EthereumSignatureDecodeResult? result = await _ethereumProvider.decodeEthereumSignature(
          message: dumbMessage,
          signatureHex: signature,
          ethereumAddress: ethereumAddress.address,
          bech32Hrp: bech32Hrp,
        );
        if (result == null) {
          throw Exception('Error decoding signature for address ${ethereumAddress.address}');
        }
        compressedHexPublicKey = result.compressedPublicKey;
        cosmosAddress = CosmosWalletAddress.fromBech32(result.cosmosAddress);
      }

      CosmosWalletAddress bech32Address = _cachedEthAddresses[ethereumAddress] = cosmosAddress;

      await _cacheManager.add<String>(
        boxName: EthereumProvider.hiveBoxName,
        key: ethereumAddress.address.toLowerCase(),
        value: jsonEncode(EthereumSignatureDecodeResult(
          compressedPublicKey: compressedHexPublicKey,
          ethAddress: ethereumAddress.address,
          cosmosAddress: bech32Address.address,
        ).toDataJson()),
      );

      AppLogger().log(message: 'Converted Cosmos Address: ${bech32Address.address}', logLevel: LogLevel.debug);
      return bech32Address;
    } catch (e) {
      AppLogger().log(message: '_cacheCosmosAddressFromEthereum - $e', logLevel: LogLevel.error);
    }
    return null;
  }

  AWalletAddress? _toOppositeAddressType() {
    if (state == null || loggedInWithAddressType == WalletAddressType.cosmos) {
      return null;
    }
    return tryFindOppositeAddress(state!.address);
  }
}
