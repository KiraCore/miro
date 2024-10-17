import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

abstract class ADecryptedKeyfileModel extends Equatable {
  final KeyfileSecretDataModel keyfileSecretDataModel;

  const ADecryptedKeyfileModel({
    required this.keyfileSecretDataModel,
  });

  Future<String> buildFileContent(String password);

  String get fileName {
    Wallet wallet = keyfileSecretDataModel.wallet;
    return 'keyfile_${wallet.address.buildShortAddress(delimiter: '_')}.json';
  }

  @override
  List<Object?> get props => <Object?>[keyfileSecretDataModel];
}
