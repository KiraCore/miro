import 'package:equatable/equatable.dart';

class SetNetworkPropertyValue extends Equatable {
  final String strValue;
  final String value;

  const SetNetworkPropertyValue({
    required this.strValue,
    required this.value,
  });

  factory SetNetworkPropertyValue.fromJson(Map<String, dynamic> json) => SetNetworkPropertyValue(
        strValue: json['strValue'] as String,
        value: json['value'] as String,
      );

  @override
  List<Object> get props => <Object>[strValue, value];
}
