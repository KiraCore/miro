import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class KeyfileSecretDataModel extends Equatable {
  final Wallet wallet;

  const KeyfileSecretDataModel({
    required this.wallet,
  });

  @override
  List<Object?> get props => <Object>[wallet];
}
