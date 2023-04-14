import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/exceptions/invalid_keyfile_exception.dart';
import 'package:miro/shared/exceptions/invalid_password_exception.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

/// Stores the content of the keyfile.json.
///
/// The keyfile is used to login into the wallet and to store user data
/// The content of the keyfile is encrypted with the AES265 algorithm, using the user's password
class KeyFile extends Equatable {
  /// Latest version of keyfile
  static const String latestVersion = '1.0.1';

  /// Keyfile wallet
  final Wallet wallet;

  /// Version of keyfile
  final String version;

  const KeyFile({
    required this.wallet,
    this.version = latestVersion,
  });

  /// Creates a Keyfile instance from encrypted file content
  ///
  /// Throws [InvalidPasswordException] if cannot decrypt secret data
  /// Throws [InvalidKeyFileException] if cannot parse file content to json
  factory KeyFile.decode(String keyFileAsString, String password) {
    late Map<String, dynamic> keyFileAsJson;
    try {
      keyFileAsJson = jsonDecode(keyFileAsString) as Map<String, dynamic>;
    } catch (_) {
      throw InvalidKeyFileException();
    }
    try {
      Map<String, dynamic> secretData = jsonDecode(
        Aes256.decrypt(
          password,
          keyFileAsJson['secretData'] as String,
        ),
      ) as Map<String, dynamic>;

      return KeyFile(
        version: keyFileAsJson['version'] as String,
        wallet: Wallet.fromKeyFileData(keyFileAsJson, secretData),
      );
    } catch (_) {
      throw InvalidPasswordException();
    }
  }

  String encode(String password) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    return encoder.convert(_encryptJson(password));
  }

  String get fileName {
    return 'keyfile_${wallet.address.buildBech32AddressShort(delimiter: '_')}.json';
  }

  Map<String, dynamic> _encryptJson(String password) {
    return <String, dynamic>{
      ..._getPublicJsonData(),
      'secretData': Aes256.encrypt(password, jsonEncode(_getPrivateJsonData()))
    };
  }

  Map<String, dynamic> _getPublicJsonData() {
    return <String, dynamic>{
      'bech32Address': wallet.address.bech32Address,
      'version': latestVersion,
    };
  }

  Map<String, dynamic> _getPrivateJsonData() {
    return <String, dynamic>{
      'privateKey': HEX.encode(wallet.privateKey),
    };
  }

  @override
  List<Object?> get props => <Object>[wallet, version];
}
