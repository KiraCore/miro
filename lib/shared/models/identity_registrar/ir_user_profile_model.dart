import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class IRUserProfileModel extends Equatable {
  final AWalletAddress walletAddress;
  final String? avatarUrl;
  final String? username;

  const IRUserProfileModel({
    required this.walletAddress,
    required this.avatarUrl,
    required this.username,
  });

  factory IRUserProfileModel.fromIrModel(IRModel irModel) {
    return IRUserProfileModel(
      walletAddress: irModel.walletAddress,
      avatarUrl: irModel.avatarIRRecordModel.value,
      username: irModel.usernameIRRecordModel.value,
    );
  }

  @override
  List<Object?> get props => <Object?>[walletAddress, avatarUrl, username];
}
