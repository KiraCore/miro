import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class Transaction extends Equatable {
  final int time;
  final String hash;
  final String status;
  final String direction;
  final String memo;
  final List<Coin> fee;
  final List<ATxMsg> txs;

  const Transaction({
    required this.time,
    required this.hash,
    required this.status,
    required this.direction,
    required this.memo,
    required this.fee,
    required this.txs,
  });

  static String _mapTypeUrlToType(String typeUrl) {
    // Map typeUrl (e.g., "/cosmos.bank.v1beta1.MsgSend") to type (e.g., "send")
    if (typeUrl.contains('MsgSend')) {
      return 'send';
    } else if (typeUrl.contains('MsgDelegate')) {
      return 'delegate';
    } else if (typeUrl.contains('MsgUndelegate')) {
      return 'undelegate';
    } else if (typeUrl.contains('MsgClaimRewards')) {
      return 'claim_rewards';
    } else if (typeUrl.contains('MsgClaimUndelegation')) {
      return 'claim_undelegation';
    } else if (typeUrl.contains('MsgRegisterIdentityRecords')) {
      return 'register_identity_records';
    } else if (typeUrl.contains('MsgDeleteIdentityRecords')) {
      return 'edit_identity_record';
    } else if (typeUrl.contains('MsgRequestIdentityRecordsVerify')) {
      return 'request_identity_records_verify';
    } else if (typeUrl.contains('MsgHandleIdentityRecordsVerifyRequest')) {
      return 'handle_identity_records_verify_request';
    } else if (typeUrl.contains('MsgCancelIdentityRecordsVerifyRequest')) {
      return 'cancel_identity_records_verify_request';
    }
    // Default to undefined if no match is found
    return 'undefined';
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    int time = json['time'] as int? ?? json['ch_time'] as int? ?? 0;

    List<dynamic> txsData = json['txs'] as List<dynamic>? ?? json['messages'] as List<dynamic>? ?? <dynamic>[];

    // Adapt messages if needed to match ATxMsg expectations
    List<dynamic> adaptedTxs = txsData.map((dynamic e) {
      if (e is Map<String, dynamic>) {
        // If type is missing but typeUrl is present, map typeUrl to type
        if (e['type'] == null && e['typeUrl'] != null) {
          String typeUrl = e['typeUrl'] as String;
          String type = _mapTypeUrlToType(typeUrl);
          return <String, dynamic>{...e, 'type': type};
        } else if (e['type'] == null) {
          // If both are null, provide a default type
          return <String, dynamic>{...e, 'type': 'undefined'};
        }
      }
      return e;
    }).toList();

    // Extract fee from the new API response structure
    List<Coin> feeList = <Coin>[];
    if (json['fee'] != null) {
      feeList = (json['fee'] as List<dynamic>).map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList();
    } else if (json['tx_result'] != null) {
      // Try to extract fee from tx_result.events
      final dynamic txResult = json['tx_result'];
      if (txResult is Map<String, dynamic> && txResult['events'] != null) {
        final List<dynamic> events = txResult['events'] as List<dynamic>;
        for (final dynamic event in events) {
          if (event is Map<String, dynamic> && event['type'] == 'tx') {
            final List<dynamic>? attributes = event['attributes'] as List<dynamic>?;
            if (attributes != null) {
              for (final dynamic attr in attributes) {
                if (attr is Map<String, dynamic> && attr['key'] == 'fee') {
                  final String feeValue = attr['value'] as String? ?? '';
                  // Parse fee string like "2000000ukex"
                  final RegExp regex = RegExp(r'^(\d+)([a-z]+)$');
                  final RegExpMatch? match = regex.firstMatch(feeValue);
                  if (match != null) {
                    feeList.add(Coin(
                      amount: match.group(1)!,
                      denom: match.group(2)!,
                    ));
                    break; // Found the fee, exit inner loop
                  }
                }
              }
            }
            // Don't break here - check all tx events for fee
            if (feeList.isNotEmpty) {
              break; // Found fee, exit outer loop
            }
          }
        }
      }
    }

    // Ensure at least one fee entry to avoid crashes
    if (feeList.isEmpty) {
      feeList.add(const Coin(amount: '0', denom: 'ukex'));
    }

    return Transaction(
      time: time,
      hash: json['hash'] as String? ?? '',
      status: json['status'] as String? ??
          (json['tx_result'] != null && (json['tx_result'] as Map<String, dynamic>)['code'] == 0
              ? 'confirmed'
              : 'failed'),
      direction: json['direction'] as String? ?? 'outbound',
      memo: json['memo'] as String? ?? '',
      fee: feeList,
      txs: adaptedTxs.map((dynamic e) => ATxMsg.buildFromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[time, hash, status, direction, memo, fee, txs];
}
