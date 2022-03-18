import 'package:bip39/bip39.dart' as bip39;
import 'package:miro/shared/utils/app_logger.dart';

enum MnemonicValidateResult {
  invalidMnemonic,
  invalidEntropy,
  invalidChecksum,
  mnemonicTooShort,
  undefinedError,
  success,
}

class Bip39Extension {
  static MnemonicValidateResult validateMnemonicWithMessage(String mnemonic) {
    List<String> mnemonicArray = mnemonic.split(' ');
    if (mnemonicArray.length < 12) {
      return MnemonicValidateResult.mnemonicTooShort;
    }
    try {
      bip39.mnemonicToEntropy(mnemonic);
    } catch (e) {
      return _exceptionToErrorStatus(e);
    }
    return MnemonicValidateResult.success;
  }

  static MnemonicValidateResult _exceptionToErrorStatus(Object error) {
    if (error is StateError) {
      return _errorMessageToErrorStatus(error.message);
    } else if (error is ArgumentError && error.message is String) {
      return _errorMessageToErrorStatus(error.message as String);
    }
    AppLogger().log(message: 'Undefined error type: ${error.runtimeType}');
    return MnemonicValidateResult.undefinedError;
  }

  static MnemonicValidateResult _errorMessageToErrorStatus(String message) {
    switch (message) {
      case 'Invalid mnemonic':
        return MnemonicValidateResult.invalidMnemonic;
      case 'Invalid entropy':
        return MnemonicValidateResult.invalidEntropy;
      case 'Invalid mnemonic checksum':
        return MnemonicValidateResult.invalidChecksum;
      default:
        AppLogger().log(message: 'Undefined error type: ${message}');
        return MnemonicValidateResult.undefinedError;
    }
  }

  static String statusToMessage(MnemonicValidateResult status) {
    switch (status) {
      case MnemonicValidateResult.invalidMnemonic:
        return 'Invalid mnemonic';
      case MnemonicValidateResult.invalidEntropy:
        return 'Invalid entropy';
      case MnemonicValidateResult.invalidChecksum:
        return 'Invalid checksum';
      case MnemonicValidateResult.mnemonicTooShort:
        return 'Mnemonic too short';
      case MnemonicValidateResult.undefinedError:
      default:
        return 'Undefined error';
    }
  }
}
