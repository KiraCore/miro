import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/utils/cryptography/bip39/mnemonic_validation_result.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class Bip39Extension {
  static MnemonicValidationResult validateMnemonicWithMessage(String mnemonic) {
    List<String> mnemonicArray = mnemonic.split(' ');
    if (mnemonicArray.length < 12) {
      return MnemonicValidationResult.mnemonicTooShort;
    }
    try {
      bip39.mnemonicToEntropy(mnemonic);
    } catch (e) {
      return _exceptionToErrorStatus(e);
    }
    return MnemonicValidationResult.success;
  }

  static MnemonicValidationResult _exceptionToErrorStatus(Object error) {
    if (error is StateError) {
      return _errorMessageToErrorStatus(error.message);
    } else if (error is ArgumentError && error.message is String) {
      return _errorMessageToErrorStatus(error.message as String);
    }
    AppLogger().log(message: 'Undefined error type: ${error.runtimeType}');
    return MnemonicValidationResult.undefinedError;
  }

  static MnemonicValidationResult _errorMessageToErrorStatus(String message) {
    switch (message) {
      case 'Invalid mnemonic':
        return MnemonicValidationResult.invalidMnemonic;
      case 'Invalid entropy':
        return MnemonicValidationResult.invalidEntropy;
      case 'Invalid mnemonic checksum':
        return MnemonicValidationResult.invalidChecksum;
      default:
        AppLogger().log(message: 'Undefined error type: ${message}');
        return MnemonicValidationResult.undefinedError;
    }
  }

  static String parseStatusToMessage(MnemonicValidationResult status, BuildContext context) {
    switch (status) {
      case MnemonicValidationResult.invalidMnemonic:
        return S.of(context).mnemonicErrorInvalid;
      case MnemonicValidationResult.invalidEntropy:
        return S.of(context).mnemonicErrorInvalidEntropy;
      case MnemonicValidationResult.invalidChecksum:
        return S.of(context).mnemonicErrorInvalidChecksum;
      case MnemonicValidationResult.mnemonicTooShort:
        return S.of(context).mnemonicErrorTooShort;
      case MnemonicValidationResult.undefinedError:
      default:
        return S.of(context).errorUndefined;
    }
  }
}
