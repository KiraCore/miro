import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/types/record_image_preview.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/types/record_text_preview.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/types/record_url_list_preview.dart';

enum RecordType {
  shortText,
  longText,
  urlList,
  list,
  image,
}

class IdentityRecordPreview extends StatelessWidget {
  final String label;
  final Record? record;
  final RecordType recordType;

  const IdentityRecordPreview({
    required this.label,
    required this.record,
    required this.recordType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (recordType) {
      case RecordType.urlList:
        return RecordUrlListPreview(label: label, record: record);
      case RecordType.image:
        return RecordImagePreview(label: label, record: record);
      default:
        return RecordTextPreview(label: label, record: record);
    }
  }
}
