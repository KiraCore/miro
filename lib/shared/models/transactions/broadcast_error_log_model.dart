import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_tx.dart';

class BroadcastErrorLogModel {
  final String code;
  final String message;

  const BroadcastErrorLogModel({
    required this.code,
    required this.message,
  });

  static BroadcastErrorLogModel? fromDto(BroadcastTx broadcastTx) {
    if (broadcastTx.code == 0) {
      return null;
    }
    String? code;
    String? message;

    try {
      List<String> humanReadableLog = _parseLogToHumanReadableValue(broadcastTx.log);

      code = humanReadableLog.first;
      message = humanReadableLog.last;
    } catch (_) {
      code = 'UNKNOWN';
      message = 'Unknown error';
    }

    String parsedCode = _parseLogCode(code);
    String parsedMessage = _parseLogMessage(message);

    return BroadcastErrorLogModel(
      code: parsedCode,
      message: parsedMessage,
    );
  }

  static List<String> _parseLogToHumanReadableValue(String fullLogMessage) {
    String fullMessage = fullLogMessage.split('\n').last;
    int dividerIndex = fullMessage.lastIndexOf(':');

    String message = fullMessage.substring(0, dividerIndex).trim();
    List<String> messageArray = message.split(';');

    String code = fullMessage.substring(dividerIndex + 1, fullMessage.length).trim();
    List<String> codeArray = code.split(';');

    if (codeArray.length > 1) {
      code = codeArray.first;
      messageArray.addAll(codeArray.sublist(1, 2));
    }
    return <String>[code, messageArray.join(';')];
  }

  static String _parseLogCode(String code) {
    return code.toUpperCase().replaceAll(' ', '_');
  }

  static String _parseLogMessage(String message) {
    List<String> messageArray = message.split(';');
    for (int i = 0; i < messageArray.length; i++) {
      String messagePart = messageArray[i].trim();
      messageArray[i] = messagePart.replaceRange(0, 1, messagePart[0].toUpperCase());
    }
    return messageArray.join('\n');
  }
}
