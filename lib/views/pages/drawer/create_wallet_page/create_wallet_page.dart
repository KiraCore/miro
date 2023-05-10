import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/a_create_wallet_page_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/create_wallet_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/states/create_wallet_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/states/create_wallet_page_loading_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/utils/app_logger.dart';
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
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/model/mnemonic_grid_controller.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateWalletPage();
}

class _CreateWalletPage extends State<CreateWalletPage> {
  final CreateWalletPageCubit createWalletPageCubit = CreateWalletPageCubit();

  final DownloadKeyfileSectionController downloadKeyfileSectionController = DownloadKeyfileSectionController();

  final KiraExpansionTileController keyfileTileController = KiraExpansionTileController();
  final KiraExpansionTileController mnemonicTileController = KiraExpansionTileController();
  final KiraExpansionTileController qrCodeTileController = KiraExpansionTileController();

  @override
  void initState() {
    super.initState();
    createWalletPageCubit.generateNewAddress();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CreateWalletPageCubit, ACreateWalletPageState>(
      bloc: createWalletPageCubit,
      builder: (BuildContext context, ACreateWalletPageState createWalletPageState) {
        bool disabledBool = true;
        String addressTextValue = S.of(context).createWalletAddressGenerating;

        if (createWalletPageState is CreateWalletPageLoadedState) {
          disabledBool = false;
          addressTextValue = createWalletPageState.wallet.address.bech32Address;
        }

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
              child: SelectableText(
                addressTextValue,
                style: textTheme.caption!.copyWith(
                  fontSize: 13,
                  color: DesignColors.white1,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: KiraOutlinedButton(
                    title: S.of(context).copy,
                    disabled: disabledBool,
                    onPressed: _pressCopyPublicAddressButton,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: KiraOutlinedButton(
                    title: S.of(context).createWalletButtonGenerateAddress,
                    disabled: disabledBool,
                    onPressed: _pressGenerateNewAddressButton,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            KiraExpansionTile(
              kiraExpansionTileController: qrCodeTileController,
              title: S.of(context).mnemonicQrReveal,
              subtitle: S.of(context).mnemonicQrWarning,
              tooltipMessage: S.of(context).mnemonicQrTip,
              disabled: disabledBool,
              children: <Widget>[
                if (createWalletPageState is CreateWalletPageLoadedState) QrCodeTileContent(mnemonic: createWalletPageState.mnemonic),
              ],
            ),
            KiraExpansionTile(
              kiraExpansionTileController: mnemonicTileController,
              title: S.of(context).mnemonicWordsReveal,
              subtitle: S.of(context).mnemonicWordsWarning,
              tooltipMessage: S.of(context).mnemonicWordsTip,
              disabled: disabledBool,
              children: <Widget>[
                if (createWalletPageState is CreateWalletPageLoadedState)
                  SecretPhrasesTileContent(
                    mnemonicGridController: MnemonicGridController(),
                    mnemonic: createWalletPageState.mnemonic,
                  ),
              ],
            ),
            KiraExpansionTile(
              kiraExpansionTileController: keyfileTileController,
              title: S.of(context).keyfileTitleDownload,
              subtitle: S.of(context).keyfileWarning,
              tooltipMessage: S.of(context).keyfileTip,
              disabled: disabledBool,
              children: <Widget>[
                if (createWalletPageState is CreateWalletPageLoadedState)
                  DownloadKeyfileSection(
                    downloadKeyfileSectionController: downloadKeyfileSectionController,
                    wallet: createWalletPageState.wallet,
                  ),
              ],
            ),
            const Divider(color: DesignColors.grey2),
            ValueListenableBuilder<bool>(
              valueListenable: createWalletPageCubit.termsCheckedNotifier,
              builder: (_, bool termsCheckedBool, __) {
                return Opacity(
                  opacity: createWalletPageState is CreateWalletPageLoadingState ? 0.3 : 1,
                  child: WalletTermsSection(
                    checked: termsCheckedBool,
                    onChanged: (bool newTermsCheckedBool) => createWalletPageCubit.termsCheckedNotifier.value = newTermsCheckedBool,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: createWalletPageCubit.termsCheckedNotifier,
              builder: (_, bool termsCheckedBool, __) {
                return KiraElevatedButton(
                  onPressed: _pressSignInButton,
                  disabled: disabledBool || termsCheckedBool == false,
                  title: S.of(context).signInButton,
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Future<void> _pressGenerateNewAddressButton() async {
    _clearPage();
    await createWalletPageCubit.generateNewAddress();
  }

  void _clearPage() {
    createWalletPageCubit.termsCheckedNotifier.value = false;
    qrCodeTileController.collapse();
    mnemonicTileController.collapse();
    keyfileTileController.collapse();

    downloadKeyfileSectionController.clear();
  }

  void _pressCopyPublicAddressButton() {
    if (createWalletPageCubit.state is CreateWalletPageLoadedState) {
      String walletAddress = (createWalletPageCubit.state as CreateWalletPageLoadedState).wallet.address.bech32Address;
      Clipboard.setData(ClipboardData(text: walletAddress));
      KiraToast.of(context).show(message: S.of(context).toastPublicAddressCopied, type: ToastType.success);
    } else {
      AppLogger().log(message: 'Error while copying the address', logLevel: LogLevel.error);
    }
  }

  void _pressSignInButton() {
    try {
      createWalletPageCubit.signIn();
      KiraScaffold.of(context).closeEndDrawer();
    } catch (_) {
      AppLogger().log(message: 'Error while signing in', logLevel: LogLevel.error);
    }
  }
}
