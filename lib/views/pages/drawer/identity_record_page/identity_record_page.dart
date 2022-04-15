import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';

class IdentityRecordPage extends StatelessWidget {
  final String label;
  final Record? record;

  const IdentityRecordPage({
    required this.label,
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: FakeTextField(
                label: label,
                emptyLabelStyle: const TextStyle(fontSize: 14),
                child: record?.value != null
                    ? Text(
                        record!.value,
                        style: const TextStyle(fontSize: 16),
                      )
                    : null,
              ),
            ),
            KiraOutlinedButton(
              width: 76,
              height: 40,
              onPressed: () {},
              title: 'Edit',
            ),
          ],
        ),
        const SizedBox(height: 15),
        const FakeTextField(
          label: 'Status',
          spacing: 8,
          emptyLabelStyle: TextStyle(fontSize: 14),
          child: StatusChip(
            value: StatusChipValue.notVerified,
          ),
        ),
      ],
    );
  }
}
