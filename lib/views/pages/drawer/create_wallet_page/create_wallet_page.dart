import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/download_keyfile_section/download_keyfile_section_controller.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/qr_code_tile_content.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/secret_phrases_tile_content.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/wallet_terms_section.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/kira_expansion_tile.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/kira_expansion_tile_controller.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DrawerTitle(title: S.of(context).createWalletTitle),
            const SizedBox(height: 24),
            const Divider(color: DesignColors.grey2),
            const SizedBox(height: 24),
            Text(
              S.of(context).createWalletAddress,
              style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                color: DesignColors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: DesignColors.grey2),
              ),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: publicAddressTextController.textController,
                builder: (_, TextEditingValue textEditingValue, __) {
                  return SelectableText(
                    textEditingValue.text.isEmpty ? S.of(context).createWalletAddressGenerating : textEditingValue.text,
                    style: textTheme.caption!.copyWith(
                      fontSize: 13,
                      color: DesignColors.white1,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: KiraOutlinedButton(
                    title: S.of(context).copy,
                    disabled: loading,
                    onPressed: _copyPublicAddress,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: KiraOutlinedButton(
                    title: S.of(context).createWalletButtonGenerateAddress,
                    disabled: loading,
                    onPressed: _createNewWallet,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<Mnemonic>(
              valueListenable: mnemonicNotifier,
              builder: (_, Mnemonic mnemonic, __) {
                return KiraExpansionTile(
                  controller: qrCodeTileController,
                  title: S.of(context).mnemonicQrReveal,
                  subtitle: S.of(context).mnemonicQrWarning,
                  tooltipMessage: S.of(context).mnemonicQrTip,
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
                  title: S.of(context).mnemonicWordsReveal,
                  subtitle: S.of(context).mnemonicWordsWarning,
                  tooltipMessage: S.of(context).mnemonicWordsTip,
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
                  title: S.of(context).keyfileTitleDownload,
                  subtitle: S.of(context).keyfileWarning,
                  tooltipMessage: S.of(context).keyfileTip,
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
            const Divider(color: DesignColors.grey2),
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
                  onPressed: _pressSignInButton,
                  disabled: !termsChecked,
                  title: S.of(context).signInButton,
                );
              },
            ),
            const SizedBox(height: 30),
          ],
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

  void _copyPublicAddress() {
    Clipboard.setData(ClipboardData(text: publicAddressTextController.textController.text));
    KiraToast.of(context).show(message: S.of(context).toastPublicAddressCopied, type: ToastType.success);
  }

  void _resetPage() {
    publicAddressTextController.textController.clear();
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

  void _pressSignInButton() {
    if (walletNotifier.value != null) {
      globalLocator<AuthCubit>().signIn(walletNotifier.value!);
      KiraScaffold.of(context).closeEndDrawer();
    }
  }
}
