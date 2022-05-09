import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/auth_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/sign_mode.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/single_mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/signer_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_body.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_pub_key.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/transaction_sign_request.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/transactions/message_signer.dart';
import 'package:miro/shared/utils/transactions/std_sign_doc.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/camera_widget.dart';
import 'package:miro/views/widgets/generic/expandable_section_tile.dart';
import 'package:miro/views/widgets/generic/qr_scanner/qr_scanner.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/kira_dropzone.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/kira_dropzone_controller.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

class TransactionScanPage extends StatefulWidget {
  final TransactionSignRequest transactionSignRequest;

  const TransactionScanPage({
    required this.transactionSignRequest,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionScanPage();
}

class _TransactionScanPage extends State<TransactionScanPage> {
  final KiraDropzoneController dropzoneController = KiraDropzoneController();
  final KiraTextFieldController signatureTextEditingController = KiraTextFieldController();
  final ExpandableSectionTileController expandableSectionTileController = ExpandableSectionTileController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogCard(
        width: 524,
        title: 'Propagate signed transaction',
        subtitle: 'Reveal QR code from Saifu app and scan',
        child: Column(
          children: <Widget>[
            _CameraButton(
              expandableSectionTileController: expandableSectionTileController,
              onDataReceived: _onReceiveSignature,
              validate: _validateSignature,
            ),
            ExpandableSectionTile(
              controller: expandableSectionTileController,
              title: 'Don`t have a camera?',
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 124,
                        width: double.infinity,
                        child: KiraDropzone(
                          title: 'Drop txt file with signature',
                          controller: dropzoneController,
                          validate: _validateDropzoneFile,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 14,
                          color: DesignColors.gray3_100,
                        ),
                      ),
                      const SizedBox(height: 8),
                      KiraTextField(
                        hint: 'Paste text from clipboard',
                        maxLines: 5,
                        validator: _validateSignature,
                        controller: signatureTextEditingController,
                      ),
                      const SizedBox(height: 16),
                      KiraOutlinedButton(
                        onPressed: _onNextPressed,
                        title: 'Confirm',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _validateDropzoneFile(DropzoneFile? file) {
    if (file == null) {
      return 'Please drop a file';
    }
    return _validateSignature(file.content);
  }

  void _onNextPressed() {
    DropzoneFile? dropzoneFile = dropzoneController.dropzoneAreaController.currentFile;
    String? dropzoneErrorMessage = _validateDropzoneFile(dropzoneFile);

    String inputSignature = signatureTextEditingController.text;
    String? inputErrorMessage = _validateSignature(inputSignature);

    if (dropzoneFile != null && dropzoneErrorMessage == null) {
      _onReceiveSignature(dropzoneFile.content);
    } else if (inputErrorMessage == null) {
      _onReceiveSignature(inputSignature);
    } else {
      KiraToast.show('You have to provide a valid signature');
    }
  }

  String? _validateSignature(String? value) {
    Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
    bool signatureValid = MessageSigner.validateRawSignature(
      address: wallet.address.addressBytes,
      signature: value ?? '',
      message: StdSignDoc(
        chainId: widget.transactionSignRequest.networkData.chainId,
        accountNumber: widget.transactionSignRequest.networkData.accountNumber,
        sequence: widget.transactionSignRequest.networkData.sequence,
        memo: widget.transactionSignRequest.unsignedTransaction.memo,
        fee: widget.transactionSignRequest.unsignedTransaction.fee,
        messages: widget.transactionSignRequest.unsignedTransaction.messages,
      ).toSignatureJson(),
    );
    if (!signatureValid) {
      return 'Invalid signature';
    }
    return null;
  }

  Future<void> _onReceiveSignature(String signature) async {
    final Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
    final TransactionSignRequest transactionSignRequest = widget.transactionSignRequest;

    final TxBody txBody = TxBody(
      messages: transactionSignRequest.unsignedTransaction.messages,
      memo: transactionSignRequest.unsignedTransaction.memo,
    );

    const ModeInfo modeInfo = ModeInfo(
      single: SingleModeInfo(
        mode: SignMode.SIGN_MODE_LEGACY_AMINO_JSON,
      ),
    );

    final SignerInfo signerInfo = SignerInfo(
      publicKey: TxPubKey(key: base64Encode(wallet.address.addressBytes)),
      modeInfo: modeInfo,
      sequence: transactionSignRequest.networkData.sequence,
    );

    final AuthInfo authInfo = AuthInfo(
      fee: transactionSignRequest.unsignedTransaction.fee,
      signerInfos: <SignerInfo>[signerInfo],
    );

    final SignedTransaction signedTransaction = SignedTransaction(
      body: txBody,
      authInfo: authInfo,
      signatures: <String>[signature],
    );

    await AutoRouter.of(context).push(TransactionConfirmRoute(signedTransaction: signedTransaction));
  }
}

class _CameraButton extends StatefulWidget {
  final VoidQrReceivedCallback onDataReceived;
  final ExpandableSectionTileController expandableSectionTileController;
  final String? Function(String value) validate;

  const _CameraButton({
    required this.onDataReceived,
    required this.expandableSectionTileController,
    required this.validate,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<_CameraButton> {
  bool cameraVisible = false;

  @override
  void initState() {
    widget.expandableSectionTileController.addListener(() {
      if (cameraVisible) {
        setState(() {
          cameraVisible = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraVisible) {
      return KiraElevatedButton(
        iconData: AppIcons.camera,
        onPressed: () {
          widget.expandableSectionTileController.closeTile();
          setState(() {
            cameraVisible = true;
          });
        },
        title: 'Scan QR code',
      );
    } else {
      return CameraWidget(
        validate: widget.validate,
        onReceiveQrCode: widget.onDataReceived,
      );
    }
  }
}
