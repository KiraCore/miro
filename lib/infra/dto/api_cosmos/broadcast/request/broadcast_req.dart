import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';

class BroadcastReq {
  final SignedTransaction transaction;
  final String mode;

  BroadcastReq({
    required this.transaction,
    this.mode = 'block',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx': transaction.toJson(),
      'mode': mode,
    };
  }
}
