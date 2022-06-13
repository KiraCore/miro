import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';

enum RecordEditMode {
  edit,
  add,
}

class EditRecordPage extends StatelessWidget {
  final RecordEditMode recordEditMode;
  final String label;
  final String recordKey;
  final String? description;
  final Record? record;

  const EditRecordPage({
    required this.recordEditMode,
    required this.label,
    required this.recordKey,
    this.description,
    this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${recordEditMode == RecordEditMode.add ? 'Add' : 'Edit'} $label',
            style: Theme.of(context).textTheme.headline1),
        if (description != null) Text(description!, style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 28),
      ],
    );
  }
}
