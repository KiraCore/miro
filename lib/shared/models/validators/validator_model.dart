import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/enum_utils.dart';

class ValidatorModel extends AListItem {
  final int top;
  final int uptime;
  final String moniker;
  final String streak;
  final String valkey;
  final StakingPoolStatus stakingPoolStatus;
  final ValidatorStatus validatorStatus;
  final WalletAddress walletAddress;
  final String? contact;
  final String? description;
  final String? logo;
  final String? social;
  final String? website;
  bool _favourite = false;

  ValidatorModel({
    required this.top,
    required this.uptime,
    required this.moniker,
    required this.streak,
    required this.valkey,
    required this.stakingPoolStatus,
    required this.validatorStatus,
    required this.walletAddress,
    this.contact,
    this.description,
    this.logo,
    this.social,
    this.website,
  });

  factory ValidatorModel.fromDto(Validator validator) {
    int top = int.parse(validator.top);
    int uptime = _calcUptime(validator);
    ValidatorStatus validatorStatus = EnumUtils.parseFromString(ValidatorStatus.values, validator.status);

    return ValidatorModel(
      top: top,
      uptime: uptime,
      moniker: validator.moniker,
      streak: validator.streak,
      stakingPoolStatus: StakingPoolStatus.fromString(validator.stakingPoolStatus),
      validatorStatus: validatorStatus,
      walletAddress: WalletAddress.fromBech32ValidatorsPage(validator.address),
      valkey: validator.valkey,
      contact: validator.contact,
      description: validator.description,
      logo: validator.logo,
      social: validator.social,
      website: validator.website,
    );
  }

  @override
  String get cacheId => walletAddress.bech32Address;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  ValidatorSimplifiedModel get validatorSimplifiedModel => ValidatorSimplifiedModel(
        walletAddress: walletAddress,
        moniker: moniker,
        logo: logo,
        website: website,
        valkey: valkey,
      );

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
    return 'ValidatorModel{top: $top, uptime: $uptime, moniker: $moniker, streak: $streak, valkey: $valkey, stakingPool: $stakingPoolStatus, validatorStatus: $validatorStatus, walletAddress: $walletAddress, contact: $contact, description: $description, logo: $logo, social: $social, website: $website, favourite: $isFavourite}';
  }
}
