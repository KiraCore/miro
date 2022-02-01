import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/exceptions/invalid_keyfile_exception.dart';
import 'package:miro/shared/exceptions/invalid_password_exception.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/create_wallet_reference_widget.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/keyfile_dropzone.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/keyfile_dropzone_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class LoginKeyfilePage extends StatefulWidget {
  const LoginKeyfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginKeyfilePage();
}

class _LoginKeyfilePage extends State<LoginKeyfilePage> {
  final KiraTextFieldController keyfilePasswordController = KiraTextFieldController();
  final KeyfileDropzoneController dropZoneController = KeyfileDropzoneController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Sign in with key file', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 12),
        Text('This is not a safe option to sign in', style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 37),
        KeyfileDropzone(
          controller: dropZoneController,
          validate: _validateKeyFile,
        ),
        const SizedBox(height: 16),
        KiraTextField(
          controller: keyfilePasswordController,
          hint: 'Enter password',
          obscureText: true,
          validator: (_) => _validateKeyFilePassword(),
        ),
        const SizedBox(height: 24),
        KiraElevatedButton(
          onPressed: _onLoginButtonPressed,
          title: 'Login',
        ),
        const Spacer(),
        const CreateWalletReferenceWidget(),
      ],
    );
  }

  String? _validateKeyFile(DropzoneFile? file) {
    if (file == null) {
      String errorMessage = 'Keyfile cannot be empty';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    }
    try {
      _getWalletFromKeyFileString(file.content);
      return null;
    } on InvalidKeyFileException catch (_) {
      String errorMessage = 'Provided invalid key file';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    } catch (e) {
      AppLogger().log(message: 'Unknown error: ${e.toString()}', logLevel: LogLevel.terribleFailure);
      return null;
    }
  }

  String? _validateKeyFilePassword() {
    DropzoneFile? file = dropZoneController.dropzoneController.currentFile;
    if (file == null) {
      String errorMessage = 'Keyfile cannot be empty';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      dropZoneController.setErrorMessage(errorMessage);
    }
    try {
      _getWalletFromKeyFileString(file!.content);
    } on InvalidPasswordException {
      String errorMessage = 'Wrong password';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    }
    return null;
  }

  void _onLoginButtonPressed() {
    bool keyfileValid = dropZoneController.validate() == null;
    bool passwordValid = keyfilePasswordController.validate() == null;

    if (keyfileValid && passwordValid) {
      Wallet wallet = _getWalletFromKeyFileString(dropZoneController.dropzoneController.currentFile!.content);
      globalLocator<WalletProvider>().updateWallet(wallet);
      KiraScaffold.of(context).closeEndDrawer();
    }
  }

  Wallet _getWalletFromKeyFileString(String keyFileEncryptedContent) {
    try {
      String password = keyfilePasswordController.textController.text;
      KeyFile keyFile = KeyFile.decode(keyFileEncryptedContent, password);
      return keyFile.wallet;
    } catch (e) {
      AppLogger().log(message: 'Unknown error: ${e.toString()}', logLevel: LogLevel.terribleFailure);
      rethrow;
    }
  }
}
