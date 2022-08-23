import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section_controller.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/qr_code_tile_content.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/secret_pharses_tile_content.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/wallet_terms_section.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/kira_expansion_tile.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/kira_expansion_tile_controller.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/model/mnemonic_grid_controller.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateWalletPage();
}

class _CreateWalletPage extends State<CreateWalletPage> {
  ValueNotifier<Mnemonic> mnemonicNotifier = ValueNotifier<Mnemonic>(Mnemonic.random());
  ValueNotifier<Wallet?> walletNotifier = ValueNotifier<Wallet?>(null);
  ValueNotifier<bool> generateStatusNotifier = ValueNotifier<bool>(true);
  ValueNotifier<bool> termsCheckedNotifier = ValueNotifier<bool>(false);

  KiraExpansionTileController qrCodeTileController = KiraExpansionTileController();
  KiraExpansionTileController mnemonicTileController = KiraExpansionTileController();
  KiraExpansionTileController keyfileTileController = KiraExpansionTileController();

  MnemonicGridController mnemonicGridController = MnemonicGridController();
  KiraTextFieldController publicAddressTextController = KiraTextFieldController();
  DownloadKeyfileSectionController downloadKeyfileSectionController = DownloadKeyfileSectionController();

  @override
  void initState() {
    super.initState();
    _createNewWallet();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder<bool>(
      valueListenable: generateStatusNotifier,
      builder: (_, bool loading, __) {
        return SizedBox(
          height: 2000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Create a wallet',
                style: textTheme.headline3!.copyWith(
                  color: DesignColors.white_100,
                ),
              ),
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
              ValueListenableBuilder<Mnemonic>(
                valueListenable: mnemonicNotifier,
                builder: (_, Mnemonic mnemonic, __) {
                  return KiraExpansionTile(
                    controller: qrCodeTileController,
                    title: 'Reveal Secret QR Code',
                    subtitle: 'You won’t be able to see it again',
                    tooltipMessage: 'You won’t be able to see it again',
                    disabled: loading,
                    children: <Widget>[QrCodeTileContent(mnemonic: mnemonic)],
                  );
                },
              ),
              ValueListenableBuilder<Mnemonic>(
                valueListenable: mnemonicNotifier,
                builder: (_, Mnemonic mnemonic, __) {
                  return KiraExpansionTile(
                    controller: mnemonicTileController,
                    title: 'Reveal Secret Phrases',
                    subtitle: 'You won’t be able to see it again',
                    tooltipMessage: 'You won’t be able to see it again',
                    disabled: loading,
                    children: <Widget>[
                      SecretPhrasesTileContent(
                        mnemonicGridController: mnemonicGridController,
                        mnemonic: mnemonic,
                      ),
                    ],
                  );
                },
              ),
              ValueListenableBuilder<Wallet?>(
                valueListenable: walletNotifier,
                builder: (_, Wallet? wallet, __) {
                  return KiraExpansionTile(
                    controller: keyfileTileController,
                    title: 'Generate keyfile',
                    tooltipMessage: 'Generate keyfile',
                    disabled: loading,
                    children: <Widget>[
                      if (wallet != null)
                        DownloadKeyfileSection(
                          controller: downloadKeyfileSectionController,
                          wallet: wallet,
                        ),
                    ],
                  );
                },
              ),
              const Divider(color: Color(0xFF343261)),
              ValueListenableBuilder<bool>(
                valueListenable: termsCheckedNotifier,
                builder: (_, bool termsChecked, __) {
                  return Opacity(
                    opacity: loading ? 0.3 : 1,
                    child: WalletTermsSection(
                      checked: termsCheckedNotifier.value,
                      onChanged: (bool value) {
                        termsCheckedNotifier.value = value;
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: termsCheckedNotifier,
                builder: (_, bool termsChecked, __) {
                  return KiraElevatedButton(
                    onPressed: _onConnectWalledPressed,
                    disabled: !termsChecked,
                    title: 'Connect wallet',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _createNewWallet() async {
    _resetPage();
    generateStatusNotifier.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 400));

    // Start heavy calculation operations
    Mnemonic mnemonic = Mnemonic.random();
    Wallet wallet = Wallet.derive(mnemonic: mnemonic);
    // End heavy calculation operations

    mnemonicNotifier.value = mnemonic;
    walletNotifier.value = wallet;
    publicAddressTextController.textController.text = wallet.address.bech32Address;
    generateStatusNotifier.value = false;
  }

  void _resetPage() {
    publicAddressTextController.textController.text = 'Generating...';
    termsCheckedNotifier.value = false;
    qrCodeTileController.collapse();
    mnemonicTileController.collapse();
    keyfileTileController.collapse();
    try {
      downloadKeyfileSectionController.clear();
    } catch (_) {
      // Do nothing because Exception throws every time when you open create wallet page
      // Its caused because LateInitializationError (controller is initialized the same time when widget is build)
    }
  }

  void _onConnectWalledPressed() {
    if (walletNotifier.value != null) {
      globalLocator<WalletProvider>().updateWallet(walletNotifier.value!);
      KiraScaffold.of(context).closeEndDrawer();
    }
  }
}
