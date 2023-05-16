import 'package:flutter/cupertino.dart';
import 'package:miro/shared/controllers/browser/browser_controller.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class DownloadKeyfileSectionController {
  final ValueNotifier<bool> downloadEnabledNotifier = ValueNotifier<bool>(false);

  final KiraTextFieldController passwordTextController = KiraTextFieldController();
  final KiraTextFieldController repeatedPasswordTextController = KiraTextFieldController();

  void clear() {
    downloadEnabledNotifier.value = false;
    passwordTextController.textController.clear();
    repeatedPasswordTextController.textController.clear();
    repeatedPasswordTextController.reloadErrorMessage();
  }

  void downloadKeyfile(Wallet wallet) {
    KeyFile keyfile = KeyFile(wallet: wallet);
    String password = passwordTextController.textController.text;
    String keyfileString = keyfile.encode(password);

    BrowserController.downloadFile(<String>[keyfileString], keyfile.fileName);
  }

  void validatePassword() {
    repeatedPasswordTextController.reloadErrorMessage();
    downloadEnabledNotifier.value = arePasswordsValid;
  }

  bool get arePasswordsValid {
    String password = passwordTextController.textController.text;
    String repeatedPassword = repeatedPasswordTextController.textController.text;
    return isRepeatedPasswordEmpty == false && password == repeatedPassword;
  }

  bool get isRepeatedPasswordEmpty {
    String repeatedPassword = repeatedPasswordTextController.textController.text;
    bool repeatedPasswordEmptyBool = repeatedPassword.isEmpty;
    return repeatedPasswordEmptyBool;
  }
}
