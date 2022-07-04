import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/shared/utils/enum_utils.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';

enum ValidatorStatus {
  active,
  inactive,
  jailed,
  paused,
  waiting,
}

class ValidatorModel implements IListItem {
  final int top;
  final String address;
  final String moniker;
  final ValidatorStatus validatorStatus;
  bool _favourite = false;

  ValidatorModel({
    required this.top,
    required this.address,
    required this.moniker,
    required this.validatorStatus,
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
  String get cacheId => address;

  @override
  bool get isFavourite => _favourite;

  @override
  set isFavourite(bool value) => _favourite = value;

  @override
  String toString() {
    return 'ValidatorModel{top: $top, address: $address, moniker: $moniker, validatorStatus: $validatorStatus, favourite: $_favourite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValidatorModel && runtimeType == other.runtimeType && address == other.address;

  @override
  int get hashCode => address.hashCode;
}
