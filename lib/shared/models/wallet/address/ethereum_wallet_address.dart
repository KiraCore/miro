import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart' show HexCodec;
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32.dart';
import 'package:miro/shared/utils/cryptography/bech32/bech32_pair.dart';

class EthereumWalletAddress extends AWalletAddress {
  const EthereumWalletAddress({required Uint8List addressBytes}) : super(addressBytes: addressBytes);

  EthereumWalletAddress.fromString(String address) : super(addressBytes: HexCodec.decode(address));

  factory EthereumWalletAddress.fromBech32(String bech32Address) {
    final Bech32Pair bech32pair = Bech32.decode(bech32Address);
    return EthereumWalletAddress(
      addressBytes: bech32pair.data,
    );
  }

  /// Returns the associated [address] as a Hash string.
  @override
  String get address => HexCodec.encode(addressBytes, includePrefixBool: true);

  String toKiraAddress() {
    String hrp = globalLocator<NetworkModuleBloc>().tokenDefaultDenomModel.bech32AddressPrefix ?? '';
    return Bech32.encode(hrp, addressBytes);
  }
}
