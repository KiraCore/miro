import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class LoginPublicKeySection extends StatefulWidget {
  final String? Function(String? publicAddress) validate;
  final void Function(String publicAddress) onLoginPressed;

  const LoginPublicKeySection({
    required this.validate,
    required this.onLoginPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPublicKeySection();
}

class _LoginPublicKeySection extends State<LoginPublicKeySection> {
  final KiraTextFieldController publicAddressTextController = KiraTextFieldController();
  bool publicAddressValid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        KiraTextField(
          kiraTextFieldController: publicAddressTextController,
          label: 'or',
          hint: 'Paste a public address',
          onChanged: _onPublicAddressChanged,
          validator: _validatePublicAddress,
        ),
        const SizedBox(height: 24),
        KiraElevatedButton(
          onPressed: _onLoginButtonPressed,
          disabled: !publicAddressValid,
          title: 'Connect a wallet',
        ),
      ],
    );
  }

  void _onLoginButtonPressed() {
    if (publicAddressValid) {
      widget.onLoginPressed(publicAddressTextController.textController.text);
    }
  }

  String? _validatePublicAddress(String? text) {
    String? errorMessage = widget.validate(text);
    publicAddressValid = errorMessage == null;
    setState(() {});
    return errorMessage;
  }

  void _onPublicAddressChanged(String address) {
    publicAddressTextController.validate();
  }
}
