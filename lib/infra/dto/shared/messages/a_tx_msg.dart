import 'package:equatable/equatable.dart';

/// Transaction message objects are shared between endpoints:
/// - QueryTransactions (as single list element in response)
/// - Broadcast (as a transaction message used in request)
/// Represents Msg interface from Kira SDK
/// https://github.com/KiraCore/sekai/blob/master/types/Msg.go
abstract class ATxMsg extends Equatable {
  final String _messageType;
  final String _signatureMessageType;

  const ATxMsg({
    required String messageType,
    required String signatureMessageType,
  })  : _messageType = messageType,
        _signatureMessageType = signatureMessageType;

  Map<String, dynamic> toJson();

  Map<String, dynamic> toJsonWithType() {
    return <String, dynamic>{
      '@type': _messageType,
      ...toJson(),
    };
  }

  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': _signatureMessageType,
      'value': toJson(),
    };
  }
}
