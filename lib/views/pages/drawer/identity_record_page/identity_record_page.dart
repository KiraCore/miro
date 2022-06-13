import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/pages/drawer/identity_record_page/verifiers_list.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/identity_record_preview.dart';

class IdentityRecordPage extends StatelessWidget {
  final String label;
  final String? description;
  final Record? record;
  final RecordType recordType;

  const IdentityRecordPage({
    required this.label,
    required this.description,
    required this.record,
    required this.recordType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool expandRecordPreview = _getExpandRecordPreview(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: IdentityRecordPreview(
                recordType: recordType,
                label: label,
                record: record,
              ),
            ),
            if (!expandRecordPreview)
              KiraOutlinedButton(
                width: 76,
                height: 40,
                onPressed: () {},
                title: 'Edit',
              ),
          ],
        ),
        if (expandRecordPreview)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: KiraOutlinedButton(
              width: double.infinity,
              height: 40,
              onPressed: () {},
              title: 'Edit',
            ),
          ),
        const SizedBox(height: 15),
        FakeTextField(
          label: 'Status',
          spacing: 8,
          emptyLabelStyle: const TextStyle(fontSize: 14),
          child: IdentityRecordStatusChip(
            loading: false,
            record: record,
          ),
        ),
        const SizedBox(height: 15),
        VerifiersList(
          record: record,
        ),
      ],
    );
  }

  bool _getExpandRecordPreview(BuildContext context) =>
      <RecordType>[
        RecordType.longText,
        RecordType.urlList,
        RecordType.list,
      ].contains(recordType) ||
      ResponsiveWidget.isSmallScreen(context);
}
