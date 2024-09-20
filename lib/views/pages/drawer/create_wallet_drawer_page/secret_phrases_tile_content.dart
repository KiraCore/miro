import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_type.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid_generated/mnemonic_grid_generated.dart';

class SecretPhrasesTileContent extends StatelessWidget {
  final Mnemonic mnemonic;

  const SecretPhrasesTileContent({
    required this.mnemonic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 500,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 26, right: 0, top: 10, bottom: 10),
            child: MnemonicGridGenerated(mnemonic: mnemonic),
          ),
        ),
        TextButton.icon(
          onPressed: () => _copyCurrentMnemonic(context),
          icon: const Icon(Icons.copy),
          label: Text(S.of(context).mnemonicWordsButtonCopy),
        ),
      ],
    );
  }

  Future<void> _copyCurrentMnemonic(BuildContext context) async {
    await FlutterClipboard.copy(mnemonic.value);
    await KiraToast.of(context).show(
      type: ToastType.success,
      message: S.of(context).mnemonicToastCopied,
    );
  }
}
