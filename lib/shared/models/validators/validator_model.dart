import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/shared/utils/enum_utils.dart';

class ValidatorModel extends AListItem {
  final int top;
  final int uptime;
  final String address;
  final String moniker;
  final String streak;
  final ValidatorStatus validatorStatus;
  bool _favourite = false;

  ValidatorModel({
    required this.top,
    required this.uptime,
    required this.address,
    required this.moniker,
    required this.streak,
    required this.validatorStatus,
  });

  factory ValidatorModel.fromDto(Validator validator) {
    int top = int.parse(validator.top);
    int uptime = _calcUptime(validator);
    ValidatorStatus validatorStatus = EnumUtils.parseFromString(ValidatorStatus.values, validator.status);

    return ValidatorModel(
      top: top,
      uptime: uptime,
      address: validator.address,
      moniker: validator.moniker,
      streak: validator.streak,
      validatorStatus: validatorStatus,
    );
  }

  @override
  String get cacheId => address;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  static int _calcUptime(Validator validator) {
    int producedBlockCounter = int.parse(validator.producedBlocksCounter);
    int missedBlockCounter = int.parse(validator.missedBlocksCounter);

    if (producedBlockCounter + missedBlockCounter > 0) {
      double uptime = producedBlockCounter / (producedBlockCounter + missedBlockCounter) * 100;
      return uptime.round();
    }
    return 0;
  }

  @override
  String toString() {
    return 'ValidatorModel{top: $top, address: $address, moniker: $moniker, validatorStatus: $validatorStatus, favourite: $isFavourite}';
  }
}
