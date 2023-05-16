import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/pages/drawer/create_wallet_drawer_page/download_keyfile_section/download_keyfile_section_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_type.dart';

class DownloadKeyfileSection extends StatefulWidget {
  final DownloadKeyfileSectionController downloadKeyfileSectionController;
  final Wallet wallet;

  const DownloadKeyfileSection({
    required this.downloadKeyfileSectionController,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DownloadKeyfileSection();
}

class _DownloadKeyfileSection extends State<DownloadKeyfileSection> {
  @override
  Widget build(BuildContext context) {
    DownloadKeyfileSectionController downloadKeyfileSectionController = widget.downloadKeyfileSectionController;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          KiraTextField(
            controller: downloadKeyfileSectionController.passwordTextController,
            label: S.of(context).keyfileCreatePassword,
            hint: S.of(context).keyfileHintPassword,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(StringUtils.whitespacesRegExp),
            ],
            obscureText: true,
            onChanged: (_) => downloadKeyfileSectionController.validatePassword(),
          ),
          const SizedBox(height: 12),
          KiraTextField(
            controller: downloadKeyfileSectionController.repeatedPasswordTextController,
            hint: S.of(context).keyfileHintRepeatPassword,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(StringUtils.whitespacesRegExp),
            ],
            obscureText: true,
            onChanged: (_) => downloadKeyfileSectionController.validatePassword(),
            validator: (_) => _selectPasswordErrorMessage(),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<bool>(
            valueListenable: downloadKeyfileSectionController.downloadEnabledNotifier,
            builder: (BuildContext context, bool downloadEnabledBool, _) {
              return KiraElevatedButton(
                onPressed: _pressDownloadButton,
                disabled: downloadEnabledBool == false,
                title: S.of(context).keyfileButtonDownload,
              );
            },
          ),
        ],
      ),
    );
  }

  void _pressDownloadButton() {
    widget.downloadKeyfileSectionController.downloadKeyfile(widget.wallet);
    KiraToast.of(context).show(
      message: S.of(context).keyfileToastDownloaded,
      type: ToastType.success,
      toastDuration: const Duration(seconds: 2),
    );
  }

  String? _selectPasswordErrorMessage() {
    bool repeatedPasswordEmptyBool = widget.downloadKeyfileSectionController.isRepeatedPasswordEmpty;
    bool passwordsValidBool = widget.downloadKeyfileSectionController.arePasswordsValid;

    if (repeatedPasswordEmptyBool == false && passwordsValidBool == false) {
      return S.of(context).keyfileErrorPasswordsMatch;
    } else {
      return null;
    }
  }
}
