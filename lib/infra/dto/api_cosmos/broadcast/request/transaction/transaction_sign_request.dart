import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';

class TransactionSignRequest {
  final UnsignedTransaction unsignedTransaction;
  final TransactionNetworkData networkData;

  TransactionSignRequest({
    required this.unsignedTransaction,
    required this.networkData,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'transaction': unsignedTransaction.toJson(),
      'network_data': networkData.toJson(),
    };
  }
}

class TransactionNetworkData {
  final String sequence;
  final String accountNumber;
  final String chainId;

  TransactionNetworkData({
    required this.sequence,
    required this.accountNumber,
    required this.chainId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sequence': sequence,
      'account_number': accountNumber,
      'chain_id': chainId,
    };
  }
}
