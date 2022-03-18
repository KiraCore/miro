import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section_controller.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/wallet_section_tile.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/wallet_terms_section.dart';
import 'package:miro/views/widgets/kira/kira_qr_code.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/mnemonic_grid.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/model/mnemonic_grid_controller.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateWalletPage();
}

class _CreateWalletPage extends State<CreateWalletPage> {
  MnemonicGridController mnemonicGridController = MnemonicGridController();
  KiraTextFieldController publicAddressTextController = KiraTextFieldController();
  DownloadKeyfileSectionController downloadKeyfileSectionController = DownloadKeyfileSectionController();
  Mnemonic currentMnemonic = Mnemonic.random();
  Wallet? currentWallet;
  bool generateNewWallet = true;

  @override
  void initState() {
    _createNewWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Create a wallet', style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFF343261)),
            const SizedBox(height: 24),
            KiraTextField(
              label: 'Your public address',
              readOnly: true,
              controller: publicAddressTextController,
              suffixIcon: IconButton(
                onPressed: _createNewWallet,
                icon: const Icon(
                  AppIcons.refresh,
                  color: DesignColors.blue1_100,
                ),
              ),
            ),
            const SizedBox(height: 20),
            WalletSectionTile(
              title: 'Reveal Secret QR Code',
              subtitle: 'You won’t be able to see it again',
              tooltipMessage: 'You won’t be able to see it again',
              disabled: generateNewWallet,
              children: <Widget>[
                const SizedBox(height: 15),
                KiraQrCode(
                  data: currentMnemonic.value,
                  size: 180,
                ),
                const SizedBox(height: 15),
              ],
            ),
            WalletSectionTile(
              title: 'Reveal Secret Phrases',
              subtitle: 'You won’t be able to see it again',
              tooltipMessage: 'You won’t be able to see it again',
              disabled: generateNewWallet,
              children: <Widget>[
                SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: MnemonicGrid(
                      mnemonicWordList: currentMnemonic.array,
                      controller: mnemonicGridController,
                      editable: false,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _copyCurrentMnemonic,
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy mnemonic'),
                ),
              ],
            ),
            WalletSectionTile(
              title: 'Generate keyfile',
              tooltipMessage: 'Generate keyfile',
              disabled: generateNewWallet,
              children: <Widget>[
                if (currentWallet != null)
                  DownloadKeyfileSection(
                    controller: downloadKeyfileSectionController,
                    wallet: currentWallet!,
                  ),
              ],
            ),
            const Divider(color: Color(0xFF343261)),
            Opacity(
              opacity: generateNewWallet ? 0.3 : 1,
              child: WalletTermsSection(
                wallet: currentWallet,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewWallet() async {
    try {
      downloadKeyfileSectionController.clear();
    } catch (_) {
      // Do nothing because Exception throws every time when you open create wallet page
      // Its caused because LateInitializationError (controller is initialized the same time when widget is build)
    }
    publicAddressTextController.textController.text = 'Generating...';
    setState(() {
      generateNewWallet = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 400));
    currentMnemonic = Mnemonic.random();
    currentWallet = Wallet.derive(mnemonic: currentMnemonic);
    publicAddressTextController.textController.text = currentWallet!.address.bech32Address;
    setState(() {
      generateNewWallet = false;
    });
  }

  Future<void> _copyCurrentMnemonic() async {
    await FlutterClipboard.copy(currentMnemonic.value);
    KiraToast.show('Address copied');
  }
}
