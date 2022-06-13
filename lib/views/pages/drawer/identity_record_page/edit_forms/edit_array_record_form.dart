import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/drawer/identity_record_page/edit_forms/edit_identity_record_controller.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:url_recognizer/url_recognizer.dart';

enum EditTextRecordFormType {
  normal,
  url,
}

class EditArrayRecordForm extends StatefulWidget {
  final EditIdentityRecordController controller;
  final EditTextRecordFormType type;
  final String? initialValue;
  final String label;

  const EditArrayRecordForm({
    required this.initialValue,
    required this.type,
    required this.controller,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditArrayRecordForm();
}

class _EditArrayRecordForm extends State<EditArrayRecordForm> {
  List<KiraTextFieldController> controllers = List<KiraTextFieldController>.empty(growable: true);

  @override
  void initState() {
    _setInitialTextControllers();
    widget.controller.setUpController(
      save: _save,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: widget.label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...controllers.map((KiraTextFieldController e) {
            if (widget.type == EditTextRecordFormType.url) {
              return UrlTextField(controller: e);
            } else {
              return KiraTextField(controller: e);
            }
          }).toList(),
          TextButton.icon(
            onPressed: _addNewRow,
            icon: const Icon(Icons.add),
            label: const Text('Add new'),
          ),
        ],
      ),
    );
  }

  void _setInitialTextControllers() {
    List<String> initialValues = List<String>.empty();
    initialValues = (widget.initialValue ?? '').split(',').where((String e) => e.isNotEmpty).toList();
    for (int i = 0; i < initialValues.length + 1; i++) {
      KiraTextFieldController kiraTextFieldController = KiraTextFieldController();
      if (i < initialValues.length) {
        kiraTextFieldController.textController.text = initialValues[i];
      }
      controllers.add(kiraTextFieldController);
    }
  }

  String? _save() {
    return controllers.map((KiraTextFieldController e) {
      return e.textController.text;
    }).join(',');
  }

  void _addNewRow() {
    if (mounted) {
      setState(() {
        controllers.add(KiraTextFieldController());
      });
    }
  }
}

class UrlTextField extends StatefulWidget {
  final KiraTextFieldController controller;

  const UrlTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UrlTextField();
}

class _UrlTextField extends State<UrlTextField> {
  ValueNotifier<SocialUrl> socialUrl = ValueNotifier<SocialUrl>(UnknownUrl(url: ''));

  @override
  void initState() {
    socialUrl.value = UrlRecognizer.findObject(url: widget.controller.textController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SocialUrl>(
      valueListenable: socialUrl,
      builder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: KiraTextField(
            controller: widget.controller,
            prefixIcon: Icon(
              socialUrl.value.icon,
              size: 18,
              color: DesignColors.gray2_100,
            ),
            onChanged: _onChanged,
          ),
        );
      },
    );
  }

  void _onChanged(String? value) {
    if (mounted) {
      socialUrl.value = UrlRecognizer.findObject(url: value ?? '');
    }
  }
}
