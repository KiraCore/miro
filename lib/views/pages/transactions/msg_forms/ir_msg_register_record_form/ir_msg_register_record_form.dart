import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_register_record_form_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_register_record_form/ir_key_text_input_formatter.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';
import 'package:miro/views/widgets/transactions/wallet_address_text_field.dart';

class IRMsgRegisterRecordForm extends StatefulWidget {
  final bool irKeyEditableBool;
  final GlobalKey<FormState> formKey;
  final TokenAmountModel feeTokenAmountModel;
  final IRMsgRegisterRecordFormModel irMsgRegisterRecordFormModel;
  final int? irValueMaxLength;
  final String? initialIdentityKey;
  final String? initialIdentityValue;
  final AWalletAddress? initialWalletAddress;

  const IRMsgRegisterRecordForm({
    required this.irKeyEditableBool,
    required this.formKey,
    required this.feeTokenAmountModel,
    required this.irMsgRegisterRecordFormModel,
    this.irValueMaxLength,
    this.initialIdentityKey,
    this.initialIdentityValue,
    this.initialWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRMsgRegisterRecordForm();
}

class _IRMsgRegisterRecordForm extends State<IRMsgRegisterRecordForm> {
  final TextEditingController identityKeyTextEditingController = TextEditingController();
  final TextEditingController identityValueTextEditingController = TextEditingController();
  final TextEditingController memoTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _assignInitialValues();
  }

  @override
  void dispose() {
    identityKeyTextEditingController.dispose();
    identityValueTextEditingController.dispose();
    memoTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WalletAddressTextField(
            label: S.of(context).txHintSendFrom,
            disabledBool: true,
            onChanged: _handleSenderAddressChanged,
            defaultWalletAddress: widget.initialWalletAddress,
          ),
          const SizedBox(height: 14),
          TxInputWrapper(
            boxConstraints: BoxConstraints(
              minHeight: 60,
              maxHeight: const ResponsiveValue<double>(largeScreen: 120, smallScreen: 94).get(context),
            ),
            child: TxTextField(
              label: S.of(context).irTxHintKey,
              disabled: widget.irKeyEditableBool == false,
              textEditingController: identityKeyTextEditingController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(StringUtils.irKeyRegExp),
                IRKeyTextInputFormatter(),
              ],
              onChanged: _handleKeyChanged,
            ),
          ),
          const SizedBox(height: 14),
          TxInputWrapper(
            boxConstraints: BoxConstraints(
                minHeight: 60,
                maxHeight: const ResponsiveValue<double>(largeScreen: 200, smallScreen: 125).get(context),
              ),
              child: TxTextField(
                label: S.of(context).irTxHintValue,
                maxLength: widget.irValueMaxLength,
                textEditingController: identityValueTextEditingController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(StringUtils.irValueRegExp),
                ],
                onChanged: _handleValueChanged,
              ),
            ),
        ],
      ),
    );
  }

  void _assignInitialValues() {
    memoTextEditingController.text = widget.irMsgRegisterRecordFormModel.memo;

    if (widget.initialIdentityKey != null) {
      identityKeyTextEditingController.text = widget.initialIdentityKey!;
      _handleKeyChanged(widget.initialIdentityKey!);
    }
    if (widget.initialIdentityValue != null) {
      identityValueTextEditingController.text = widget.initialIdentityValue!;
      _handleValueChanged(widget.initialIdentityValue!);
    }
  }

  void _handleSenderAddressChanged(AWalletAddress? walletAddress) {
    widget.irMsgRegisterRecordFormModel.senderWalletAddress = walletAddress;
  }

  void _handleKeyChanged(String key) {
    widget.irMsgRegisterRecordFormModel.identityKey = key;
  }

  void _handleValueChanged(String value) {
    widget.irMsgRegisterRecordFormModel.identityValue = value;
  }
}
