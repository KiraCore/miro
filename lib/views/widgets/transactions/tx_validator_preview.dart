import 'package:flutter/material.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class TxValidatorPreview extends StatelessWidget {
  final String label;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  const TxValidatorPreview({
    required this.label,
    required this.validatorSimplifiedModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxInputWrapper(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          KiraIdentityAvatar(
            address: validatorSimplifiedModel.walletAddress.bech32Address,
            size: 45,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TxTextField(
                disabled: true,
                maxLines: 1,
                label: label,
                textEditingController: TextEditingController(text: validatorSimplifiedModel.moniker),
                onChanged: (_) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
