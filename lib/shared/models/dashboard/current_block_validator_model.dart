import 'package:equatable/equatable.dart';

class CurrentBlockValidatorModel extends Equatable {
  final String address;
  final String moniker;

  const CurrentBlockValidatorModel({
    required this.address,
    required this.moniker,
  });

  @override
  List<Object?> get props => <Object>[moniker, address];
}
