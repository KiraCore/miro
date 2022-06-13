import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/identity_record_page/edit_forms/edit_array_record_form.dart';
import 'package:miro/views/pages/drawer/identity_record_page/edit_forms/edit_identity_record_controller.dart';
import 'package:miro/views/pages/drawer/identity_record_page/edit_forms/edit_text_record_form.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/identity_record_preview.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

enum RecordEditMode {
  edit,
  add,
}

class EditRecordPage extends StatefulWidget {
  final RecordEditMode recordEditMode;
  final RecordType recordType;
  final String label;
  final String recordKey;
  final String? description;
  final Record? record;

  const EditRecordPage({
    required this.recordEditMode,
    required this.recordType,
    required this.label,
    required this.recordKey,
    this.description,
    this.record,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditRecordPage();
}

class _EditRecordPage extends State<EditRecordPage> {
  final EditIdentityRecordController editIdentityRecordController = EditIdentityRecordController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${widget.recordEditMode == RecordEditMode.add ? 'Add' : 'Edit'} ${widget.label}',
            style: Theme.of(context).textTheme.headline1),
        if (widget.description != null) Text(widget.description!, style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 28),
        _buildEditForm(),
        const SizedBox(height: 12),
        const ToastContainer(
          width: double.infinity,
          title: Text('After you update an entry, all your verifications will be lost'),
          toastType: ToastType.warning,
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            KiraElevatedButton(
              width: 76,
              height: 48,
              title: 'Save',
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            KiraOutlinedButton(
              width: 76,
              height: 48,
              title: 'Cancel',
              onPressed: () {
                KiraScaffold.of(context).popEndDrawer();
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildEditForm() {
    switch (widget.recordType) {
      case RecordType.urlList:
        return EditArrayRecordForm(
          initialValue: widget.record?.value,
          type: EditTextRecordFormType.url,
          controller: editIdentityRecordController,
          label: widget.label,
        );
      case RecordType.list:
        return EditArrayRecordForm(
          initialValue: widget.record?.value,
          type: EditTextRecordFormType.normal,
          controller: editIdentityRecordController,
          label: widget.label,
        );
      case RecordType.shortText:
        return EditTextRecordForm(
          initialValue: widget.record?.value,
          controller: editIdentityRecordController,
          label: widget.label,
          shortText: true,
        );
      case RecordType.longText:
        return EditTextRecordForm(
          initialValue: widget.record?.value,
          controller: editIdentityRecordController,
          label: widget.label,
          shortText: false,
        );
      default:
        return Text('Unknown record type: ${widget.recordType}');
    }
  }
}
