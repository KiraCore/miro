import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';

class UnsignedTransaction {
  final List<TxMsg> messages;
  final String memo;
  final TxFee fee;

  UnsignedTransaction({
    required this.messages,
    required this.memo,
    required this.fee,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'messages': messages.map((TxMsg e) => e.toJson()).toList(),
      'memo': memo,
      'fee': fee.toJson(),
    };
  }
}
