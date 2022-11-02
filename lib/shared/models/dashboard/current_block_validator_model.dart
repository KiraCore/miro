import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/dashboard/current_block_validator.dart';

class CurrentBlockValidatorModel extends Equatable {
  final String address;
  final String moniker;

  const CurrentBlockValidatorModel({
    required this.address,
    required this.moniker,
  });

  factory CurrentBlockValidatorModel.fromDto(CurrentBlockValidator currentBlockValidator) {
    return CurrentBlockValidatorModel(
      address: currentBlockValidator.address,
      moniker: currentBlockValidator.moniker,
    );
  }

  @override
  List<Object?> get props => <Object>[moniker, address];
}
