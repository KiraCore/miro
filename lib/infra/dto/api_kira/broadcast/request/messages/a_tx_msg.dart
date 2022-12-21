import 'package:equatable/equatable.dart';

/// Parent class to define transaction messages methods
abstract class ATxMsg extends Equatable {
  final String _messageType;
  final String _signatureMessageType;

  const ATxMsg({
    required String messageType,
    required String signatureMessageType,
  }) : _messageType = messageType,
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
