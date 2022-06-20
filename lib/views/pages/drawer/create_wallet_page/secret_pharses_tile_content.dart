import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/mnemonic_grid_preview/mnemonic_grid_preview.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

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
          height: 450,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: MnemonicGridPreview(
              mnemonic: mnemonic,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () => _copyCurrentMnemonic(context),
          icon: const Icon(Icons.copy),
          label: const Text('Copy mnemonic'),
        ),
      ],
    );
  }

  Future<void> _copyCurrentMnemonic(BuildContext context) async {
    await FlutterClipboard.copy(mnemonic.value);
    await KiraToast.of(context).show(
      type: ToastType.success,
      message: 'Mnemonic successfully copied',
    );
  }
}
