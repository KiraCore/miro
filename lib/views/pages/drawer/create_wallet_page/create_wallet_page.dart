import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/mnemonic_grid_tile.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateWalletPage();
}

class _CreateWalletPage extends State<CreateWalletPage> {
  Mnemonic currentMnemonic = Mnemonic.random();
  bool loadingStatus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Create account', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 12),
        Text('Put this words in safe place', style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 28),
        GridView.builder(
          itemCount: currentMnemonic.array.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return MnemonicGridTile(mnemonicWord: currentMnemonic.array[index]);
          },
        ),
        const SizedBox(height: 28),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _copyCurrentMnemonic,
                label: const Text('Copy'),
                icon: const Icon(Icons.copy, size: 16),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _generateNewMnemonic,
                label: const Text('Generate again'),
                icon: const Icon(Icons.refresh, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        KiraOutlinedButton(
          onPressed: _onCreateAccountPressed,
          title: 'Create Account',
        ),
        const SizedBox(height: 28),
        if (loadingStatus)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('Generating account...'),
            ],
          )
      ],
    );
  }

  Future<void> _copyCurrentMnemonic() async {
    await FlutterClipboard.copy(currentMnemonic.value);
    KiraToast.show('Address copied');
  }

  Future<void> _generateNewMnemonic() async {
    setState(() {
      currentMnemonic = Mnemonic.random();
    });
  }

  Future<void> _onCreateAccountPressed() async {
    // TODO(dominik): action after wallet created
  }
}
