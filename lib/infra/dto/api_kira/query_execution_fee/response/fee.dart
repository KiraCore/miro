import 'package:equatable/equatable.dart';

class Fee extends Equatable {
  final String defaultParameters;
  final String executionFee;
  final String failureFee;
  final String timeout;
  final String transactionType;

  const Fee({
    required this.defaultParameters,
    required this.executionFee,
    required this.failureFee,
    required this.timeout,
    required this.transactionType,
  });

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      defaultParameters: json['defaultParameters'] as String,
      executionFee: json['executionFee'] as String,
      failureFee: json['failureFee'] as String,
      timeout: json['timeout'] as String,
      transactionType: json['transactionType'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[defaultParameters, executionFee, failureFee, timeout, transactionType];
}
