import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';

class UnsignedTxModel extends Equatable {
  final TxLocalInfoModel txLocalInfoModel;
  final TxRemoteInfoModel txRemoteInfoModel;

  const UnsignedTxModel({
    required this.txLocalInfoModel,
    required this.txRemoteInfoModel,
  });

  @override
  List<Object?> get props => <Object>[txLocalInfoModel, txRemoteInfoModel];
}
