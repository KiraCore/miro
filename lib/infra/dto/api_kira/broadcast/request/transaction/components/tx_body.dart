import 'dart:convert';

import 'package:miro/infra/dto/api_kira/broadcast/request/messages/a_tx_msg.dart';

/// TxBody is the body of a transaction that all signers sign over
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.TxBody
class TxBody {
  /// A list of messages to be executed. The required signers of those messages define
  /// the number and order of elements in AuthInfo's signer_infos and Tx's signatures.
  /// Each required signer address is added to the list only the first time it occurs.
  ///
  /// By convention, the first required signer (usually from the first message) is referred
  /// to as the primary signer and pays the fee for the whole transaction.
  final List<ATxMsg> messages;

  /// Arbitrary note/comment to be added to the transaction.
  ///
  /// WARNING: in clients, any publicly exposed text should not be called memo,
  /// but should be called note instead (see https://github.com/cosmos/cosmos-sdk/issues/9122).
  final String memo;

  /// Block height after which this transaction will not be processed by the chain
  final String timeoutHeight;

  /// Arbitrary options that can be added by chains when the default options are not sufficient.
  /// If any of these are present and can't be handled, the transaction will be rejected
  final List<dynamic>? extensionOptions;

  /// Arbitrary options that can be added by chains when the default options are not sufficient.
  /// If any of these are present and can't be handled, they will be ignored
  final List<dynamic>? nonCriticalExtensionOptions;

  TxBody({
    required this.messages,
    required this.memo,
    this.timeoutHeight = '0',
    this.extensionOptions,
    this.nonCriticalExtensionOptions,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'messages': messages.map((ATxMsg txMsg) => txMsg.toJsonWithType()).toList(),
        'memo': memo,
        'timeout_height': timeoutHeight,
        'extension_options': extensionOptions ?? <dynamic>[],
        'non_critical_extension_options': nonCriticalExtensionOptions ?? <dynamic>[],
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
