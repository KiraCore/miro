import 'package:flutter/cupertino.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/browser_utils.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class DownloadKeyfileSection extends StatefulWidget {
  final DownloadKeyfileSectionController controller;
  final Wallet wallet;

  const DownloadKeyfileSection({
    required this.controller,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DownloadKeyfileSection();
}

class _DownloadKeyfileSection extends State<DownloadKeyfileSection> {
  KiraTextFieldController passwordTextController = KiraTextFieldController();
  KiraTextFieldController repeatPasswordTextController = KiraTextFieldController();
  bool downloadKeyfileButtonEnabled = false;
  Color? downloadButtonForegroundColor;
  String? downloadButtonText;
  IconData? downloadButtonIcon;

  @override
  void initState() {
    _initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          KiraTextField(
            label: 'Create password for keyfile',
            hint: 'Password',
            controller: passwordTextController,
            obscureText: true,
            onChanged: (_) => _onPasswordChanged(),
          ),
          const SizedBox(height: 12),
          KiraTextField(
            controller: repeatPasswordTextController,
            hint: 'Repeat password',
            obscureText: true,
            onChanged: (_) {
              _onPasswordChanged();
              repeatPasswordTextController.validate();
            },
            validator: (_) => _validatePasswords(),
          ),
          const SizedBox(height: 12),
          KiraElevatedButton(
            onPressed: _downloadKeyFile,
            foregroundColor: downloadButtonForegroundColor,
            disabled: !downloadKeyfileButtonEnabled,
            title: downloadButtonText ?? 'Download',
            iconData: downloadButtonIcon,
          ),
        ],
      ),
    );
  }

  void _initController() {
    widget.controller.initController(clear: _clearKeyfile);
  }

  void _clearKeyfile() {
    passwordTextController.textController.clear();
    repeatPasswordTextController.textController.clear();
    downloadKeyfileButtonEnabled = false;
    downloadButtonForegroundColor = null;
    downloadButtonText = null;
    downloadButtonIcon = null;
  }

  void _onPasswordChanged() {
    bool passwordEmpty = passwordTextController.textController.text.isEmpty;
    bool passwordsEqual =
        passwordTextController.textController.text == repeatPasswordTextController.textController.text;

    if (!passwordEmpty && passwordsEqual) {
      _setCanDownloadKeyfile(status: true);
    } else {
      _setCanDownloadKeyfile(status: false);
    }
  }

  void _setCanDownloadKeyfile({required bool status}) {
    setState(() {
      downloadKeyfileButtonEnabled = status;
    });
  }

  void _downloadKeyFile() {
    bool isPasswordValid = _validatePasswords() == null;
    if (isPasswordValid) {
      KeyFile keyFile = KeyFile(wallet: widget.wallet);
      String encryptedKeyFileAsString = keyFile.encode(passwordTextController.textController.text);
      BrowserUtils.downloadFile(<String>[encryptedKeyFileAsString], keyFile.fileName);
    }
    setState(() {
      downloadButtonText = 'Downloaded';
      downloadButtonIcon = AppIcons.done;
      downloadButtonForegroundColor = DesignColors.green_100;
    });
  }

  String? _validatePasswords() {
    if (repeatPasswordTextController.textController.text.isEmpty) {
      return 'Field cannot be empty';
    }
    if (repeatPasswordTextController.textController.text != passwordTextController.textController.text) {
      return 'Passwords doesn\'t match';
    }
    return null;
  }
}
