import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/shared/utils/enum_utils.dart';

enum ValidatorStatus {
  active,
  inactive,
  jailed,
  paused,
  waiting,
}

class ValidatorModel {
  final int top;
  final String address;
  final String moniker;
  final ValidatorStatus validatorStatus;
  bool favourite;

  ValidatorModel({
    required this.top,
    required this.address,
    required this.moniker,
    required this.validatorStatus,
    this.favourite = false,
  });

  factory ValidatorModel.fromDto(Validator validator) {
    return ValidatorModel(
      top: int.parse(validator.top),
      address: validator.address,
      moniker: validator.moniker,
      validatorStatus: EnumUtils.parseFromString(ValidatorStatus.values, validator.status),
    );
  }

  @override
  String toString() {
    return 'ValidatorModel{top: $top, address: $address, moniker: $moniker, validatorStatus: $validatorStatus, favourite: $favourite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValidatorModel && runtimeType == other.runtimeType && address == other.address;

  @override
  int get hashCode => address.hashCode;
}
