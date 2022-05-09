
import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet_details.dart';

abstract class Wallet extends Equatable {
  /// The wallet address instance
  WalletAddress get address;

  /// Blockchain network details
  WalletDetails get walletDetails;

  @override
  List<Object> get props => <Object>[address];
}
