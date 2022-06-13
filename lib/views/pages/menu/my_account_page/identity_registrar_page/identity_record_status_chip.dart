import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';

class IdentityRecordStatusChip extends StatelessWidget {
  final bool loading;
  final Record? record;

  const IdentityRecordStatusChip({
    required this.loading,
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusChip(
      type: statusChipType,
      label: label,
      icon: icon,
    );
  }

  StatusChipType? get statusChipType {
    if (loading) {
      return StatusChipType.loading;
    } else if (record != null && record!.verifiers.isNotEmpty) {
      return StatusChipType.success;
    }
    return null;
  }

  String get label {
    switch (statusChipType) {
      case StatusChipType.loading:
        return 'Loading...';
      case StatusChipType.success:
        return 'Verified';
      default:
        return 'Not verified';
    }
  }

  Icon? get icon {
    if (statusChipType == StatusChipType.success) {
      return const Icon(
        AppIcons.verification,
      );
    }
  }
}
