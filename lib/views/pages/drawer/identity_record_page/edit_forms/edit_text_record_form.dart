import 'package:flutter/cupertino.dart';
import 'package:miro/views/pages/drawer/identity_record_page/edit_forms/edit_identity_record_controller.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class EditTextRecordForm extends StatefulWidget {
  final EditIdentityRecordController controller;
  final String? initialValue;
  final String label;
  final bool shortText;

  const EditTextRecordForm({
    required this.initialValue,
    required this.controller,
    required this.label,
    required this.shortText,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditTextRecordForm();
}

class _EditTextRecordForm extends State<EditTextRecordForm> {
  final KiraTextFieldController kiraTextFieldController = KiraTextFieldController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      kiraTextFieldController.textController.text = widget.initialValue!;
    }
    widget.controller.setUpController(
      save: _save,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: widget.label,
      child: KiraTextField(
        controller: kiraTextFieldController,
        maxLines: widget.shortText ? 1 : 10,
        validator: _validate,
      ),
    );
  }

  String? _save() {
    String? errorMessage = kiraTextFieldController.validate();
    if (errorMessage == null) {
      return kiraTextFieldController.textController.text;
    }
    return null;
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }
}
