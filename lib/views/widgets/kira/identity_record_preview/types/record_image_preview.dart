import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';

class RecordImagePreview extends StatelessWidget {
  final String label;
  final Record? record;

  const RecordImagePreview({
    required this.label,
    this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FakeTextField(
      label: label,
      emptyLabelStyle: const TextStyle(fontSize: 14),
      child: record == null || record!.value == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.network(
                record!.value!,
                width: 100,
              ),
            ),
    );
  }
}
