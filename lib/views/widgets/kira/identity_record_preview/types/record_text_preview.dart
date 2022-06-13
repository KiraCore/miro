import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';

class RecordTextPreview extends StatelessWidget {
  final String label;
  final Record? record;

  const RecordTextPreview({
    required this.label,
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: label,
      emptyLabelStyle: const TextStyle(fontSize: 14),
      child: record != null && record!.value != null
          ? SizedBox(
              width: double.infinity,
              child: Text(
                record!.value!,
                style: const TextStyle(fontSize: 16),
              ),
            )
          : null,
    );
  }
}
