import 'package:equatable/equatable.dart';

class NetworkPropertyValueModel extends Equatable {
  final String strValue;
  final String value;

  const NetworkPropertyValueModel({
    required this.strValue,
    required this.value,
  });

  @override
  List<Object> get props => <Object>[strValue, value];
}
