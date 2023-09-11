import 'package:bip39/bip39.dart' as bip39;

// ignore: implementation_imports
import 'package:bip39/src/wordlists/english.dart' as words;
import 'package:miro/shared/utils/cryptography/bip39/mnemonic_validation_result.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class Bip39Extension {
  static String findMnemonicWord(String wordPattern) {
    String hintText = words.WORDLIST.firstWhere((String mnemonicWord) {
      return mnemonicWord.toLowerCase().startsWith(wordPattern);
    }, orElse: () => '');
    return hintText;
  }

  static bool isMnemonicWordValid(String word) {
    String hintText = words.WORDLIST.firstWhere((String correctMnemonicWord) {
      return correctMnemonicWord.toLowerCase() == word;
    }, orElse: () => '');
    return hintText.isNotEmpty;
  }

  static MnemonicValidationResult validateMnemonic({required List<String> mnemonicList, required int mnemonicSize}) {
    List<String> filteredMnemonicList = mnemonicList.where((String mnemonicWord) => mnemonicWord.isNotEmpty).toList();
    if (filteredMnemonicList.length < mnemonicSize) {
      return MnemonicValidationResult.mnemonicTooShort;
    }
    try {
      bip39.mnemonicToEntropy(filteredMnemonicList.join(' '));
    } catch (e) {
      MnemonicValidationResult mnemonicValidationResult = _parseExceptionToErrorStatus(e);
      return mnemonicValidationResult;
    }
    return MnemonicValidationResult.success;
  }

  static MnemonicValidationResult _parseExceptionToErrorStatus(Object error) {
    if (error is StateError) {
      return _parsePackageExceptionMessage(error.message);
    } else if (error is ArgumentError && error.message is String) {
      return _parsePackageExceptionMessage(error.message as String);
    }
    AppLogger().log(message: 'Undefined error type: ${error.runtimeType}');
    return MnemonicValidationResult.invalidMnemonic;
  }

  static MnemonicValidationResult _parsePackageExceptionMessage(String message) {
    switch (message) {
      case 'Invalid mnemonic':
        return MnemonicValidationResult.invalidMnemonic;
      case 'Invalid entropy':
        return MnemonicValidationResult.invalidMnemonic;
      case 'Invalid mnemonic checksum':
        return MnemonicValidationResult.invalidChecksum;
      default:
        AppLogger().log(message: 'Undefined error type: ${message}');
        return MnemonicValidationResult.invalidMnemonic;
    }
  }
}
