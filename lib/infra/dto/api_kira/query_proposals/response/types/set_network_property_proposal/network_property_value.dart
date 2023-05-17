import 'package:equatable/equatable.dart';

class NetworkPropertyValue extends Equatable {
  final String strValue;
  final String value;

  const NetworkPropertyValue({
    required this.strValue,
    required this.value,
  });

  factory NetworkPropertyValue.fromJson(Map<String, dynamic> json) => NetworkPropertyValue(
        strValue: json['strValue'] as String,
        value: json['value'] as String,
      );

  @override
  List<Object> get props => <Object>[strValue, value];
}
