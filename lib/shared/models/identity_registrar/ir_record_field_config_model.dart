import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_field_type.dart';

class IRRecordFieldConfigModel extends Equatable {
  final String label;
  final IRRecordFieldType irRecordFieldType;
  final int? valueMaxLength;

  const IRRecordFieldConfigModel({
    required this.label,
    required this.irRecordFieldType,
    this.valueMaxLength,
  });

  @override
  List<Object?> get props => <Object?>[label, irRecordFieldType, valueMaxLength];
}
