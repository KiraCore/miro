import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';

class IdentityRecordModel {
  final String key;
  final String value;

  IdentityRecordModel({
    required this.key,
    required this.value,
  });

  factory IdentityRecordModel.fromDto(Record record) {
    return IdentityRecordModel(
      key: record.key,
      value: record.value,
    );
  }
}
