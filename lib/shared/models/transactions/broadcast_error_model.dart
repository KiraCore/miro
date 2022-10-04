import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_tx.dart';

class BroadcastErrorModel {
  final String name;
  final String message;

  const BroadcastErrorModel({
    required this.name,
    required this.message,
  });

  static BroadcastErrorModel? fromDto(BroadcastTx broadcastTx) {
    if (broadcastTx.code == 0) {
      return null;
    }
    List<String>? errorMessageArray;
    String? errorName;

    try {
      List<String> clearErrorLogArray = _findHumanReadableErrorLog(broadcastTx.log);

      errorName = clearErrorLogArray.last;
      errorMessageArray = clearErrorLogArray.first.split(';');
    } catch (_) {
      errorName = 'Unknown error';
      errorMessageArray = <String>['Unknown error'];
    }

    String parsedErrorName = _parseErrorName(errorName);
    String parsedErrorMessage = _parseErrorMessage(errorMessageArray);

    return BroadcastErrorModel(
      name: parsedErrorName,
      message: parsedErrorMessage,
    );
  }

  static List<String> _findHumanReadableErrorLog(String fullLogMessage) {
    String message = fullLogMessage.split('\n').last;
    int dividerIndex = message.lastIndexOf(':');
    List<String> errorArray = <String>[
      message.substring(0, dividerIndex).trim(),
      message.substring(dividerIndex + 1, message.length).trim(),
    ];
    return errorArray;
  }

  static String _parseErrorName(String errorName) {
    return errorName.toUpperCase().replaceAll(' ', '_');
  }

  static String _parseErrorMessage(List<String> errorMessageArray) {
    for (int i = 0; i < errorMessageArray.length; i++) {
      String errorMessagePart = errorMessageArray[i].trim();
      errorMessageArray[i] = errorMessagePart.replaceRange(0, 1, errorMessagePart[0].toUpperCase());
    }
    return errorMessageArray.join('\n');
  }
}
