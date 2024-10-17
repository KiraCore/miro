import 'package:flutter/cupertino.dart';
import 'package:miro/shared/controllers/browser/browser_controller.dart';
import 'package:miro/shared/models/keyfile/decrypted/cosmos_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class DownloadKeyfileSectionController {
  final ValueNotifier<bool> downloadEnabledNotifier = ValueNotifier<bool>(false);

  final KiraTextFieldController passwordTextController = KiraTextFieldController();
  final KiraTextFieldController repeatedPasswordTextController = KiraTextFieldController();

  void clear() {
    downloadEnabledNotifier.value = false;
    passwordTextController.textEditingController.clear();
    repeatedPasswordTextController.textEditingController.clear();
    repeatedPasswordTextController.reloadErrorMessage();
  }

  void close() {
    downloadEnabledNotifier.dispose();
    passwordTextController.close();
    repeatedPasswordTextController.close();
  }

  Future<void> downloadKeyfile(Wallet wallet) async {
    CosmosDecryptedKeyfileModel decryptedKeyfileModel = CosmosDecryptedKeyfileModel(
      keyfileSecretDataModel: KeyfileSecretDataModel(wallet: wallet),
    );

    String password = passwordTextController.textEditingController.text;
    String fileContent = await decryptedKeyfileModel.buildFileContent(password);
    BrowserController.downloadFile(<String>[fileContent], decryptedKeyfileModel.fileName);
  }

  void validatePassword() {
    repeatedPasswordTextController.reloadErrorMessage();
    downloadEnabledNotifier.value = arePasswordsValid;
  }

  bool get arePasswordsValid {
    String password = passwordTextController.textEditingController.text;
    String repeatedPassword = repeatedPasswordTextController.textEditingController.text;
    return isRepeatedPasswordEmpty == false && password == repeatedPassword;
  }

  bool get isRepeatedPasswordEmpty {
    String repeatedPassword = repeatedPasswordTextController.textEditingController.text;
    bool repeatedPasswordEmptyBool = repeatedPassword.isEmpty;
    return repeatedPasswordEmptyBool;
  }
}
