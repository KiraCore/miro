import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';

class SignedTxModel extends Equatable {
  final String publicKeyCompressed;
  final TxLocalInfoModel txLocalInfoModel;
  final TxRemoteInfoModel txRemoteInfoModel;
  final SignatureModel signatureModel;

  const SignedTxModel({
    required this.publicKeyCompressed,
    required this.txLocalInfoModel,
    required this.txRemoteInfoModel,
    required this.signatureModel,
  });

  @override
  List<Object?> get props => <Object>[publicKeyCompressed, txLocalInfoModel, txRemoteInfoModel, signatureModel];
}
