import 'package:equatable/equatable.dart';

class CurrentBlockValidator extends Equatable {
  final String moniker;
  final String address;

  const CurrentBlockValidator({
    required this.moniker,
    required this.address,
  });

  factory CurrentBlockValidator.fromJson(Map<String, dynamic> json) {
    return CurrentBlockValidator(
      moniker: json['moniker'] as String,
      address: json['address'] as String,
    );
  }

  @override
  String toString() {
    return 'CurrentBlockValidator{moniker: $moniker, address: $address}';
  }

  @override
  List<Object?> get props => <Object>[
        moniker,
        address,
      ];
}
