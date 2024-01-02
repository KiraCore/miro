import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class DecryptedKeyfileModel extends Equatable {
  final KeyfileSecretDataModel keyfileSecretDataModel;
  final String? version;

  const DecryptedKeyfileModel({
    required this.keyfileSecretDataModel,
    this.version,
  });

  String get fileName {
    Wallet wallet = keyfileSecretDataModel.wallet;
    return 'keyfile_${wallet.address.buildBech32AddressShort(delimiter: '_')}.json';
  }

  @override
  List<Object?> get props => <Object?>[keyfileSecretDataModel, version];
}
