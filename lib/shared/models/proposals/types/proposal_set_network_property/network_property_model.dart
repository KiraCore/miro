import 'package:equatable/equatable.dart';

class NetworkPropertyModel extends Equatable {
  final String strValue;
  final String value;

  const NetworkPropertyModel({
    required this.strValue,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'strValue': strValue,
      'value': value,
    };
  }

  @override
  List<Object> get props => <Object>[strValue, value];
}
