import 'package:equatable/equatable.dart';

class PubKey extends Equatable {
  final String type;
  final String value;

  const PubKey({
    required this.type,
    required this.value,
  });

  factory PubKey.fromJson(Map<String, dynamic> json) => PubKey(
        type: json['@type'] as String,
        value: json['value'] as String,
      );

  @override
  List<Object?> get props => <Object?>[type, value];
}
