import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class AddVerifierButton extends StatefulWidget {
  const AddVerifierButton({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddVerifierButton();
}

class _AddVerifierButton extends State<AddVerifierButton> {
  final KiraTextFieldController kiraTextFieldController = KiraTextFieldController();
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _buildStateWidget(),
    );
  }

  Widget _buildStateWidget() {
    if (editing) {
      return _EditingVerifierWidget(
        kiraTextFieldController: kiraTextFieldController,
        onSave: _onSave,
        onCancel: () => _setEditingStatus(status: false),
      );
    }
    return _AddMoreButton(
      onPressed: () => _setEditingStatus(status: true),
    );
  }

  void _onSave() {}

  void _setEditingStatus({required bool status}) {
    if (mounted) {
      setState(() {
        editing = status;
      });
    }
  }
}

class _AddMoreButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddMoreButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TextButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            foregroundColor: MaterialStateProperty.all(DesignColors.blue1_100),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Add more'),
        ),
      ],
    );
  }
}

class _EditingVerifierWidget extends StatelessWidget {
  final KiraTextFieldController kiraTextFieldController;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const _EditingVerifierWidget({
    required this.kiraTextFieldController,
    required this.onCancel,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: KiraTextField(
            controller: kiraTextFieldController,
            validator: _validate,
            hint: 'Enter address',
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            KiraElevatedButton(
              width: 133,
              height: 40,
              title: 'Send request',
              onPressed: _onSaveButtonPressed,
            ),
            const SizedBox(width: 10),
            KiraOutlinedButton(
              width: 89,
              height: 40,
              title: 'Cancel',
              onPressed: _onCancelButtonPressed,
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    try {
      WalletAddress.fromBech32(value);
    } catch (_) {
      return 'Invalid address';
    }
    return null;
  }

  void _onCancelButtonPressed() {
    kiraTextFieldController.textController.clear();
    onCancel();
  }

  void _onSaveButtonPressed() {
    String? errorMessage = kiraTextFieldController.validate();
    if (errorMessage == null) {
      onSave();
      kiraTextFieldController.textController.clear();
    }
  }
}
