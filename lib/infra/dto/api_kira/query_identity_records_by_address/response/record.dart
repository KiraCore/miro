import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final String address;
  final DateTime date;
  final String id;
  final String key;
  final String? value;
  final List<String> verifiers;

  const Record({
    required this.address,
    required this.date,
    required this.id,
    required this.key,
    required this.value,
    this.verifiers = const <String>[],
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      address: json['address'] as String,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String,
      key: json['key'] as String,
      value: json['value'] as String?,
      verifiers: json['verifiers'] != null ? json['verifiers'] as List<String> : List<String>.empty(),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        address,
        date,
        id,
        key,
        value,
        verifiers,
      ];
}

class NewRecord extends Record {
  const NewRecord({required String key, required DateTime date})
      : super(
          key: key,
          date: date,
          address: '',
          id: '',
          value: null,
        );
}
