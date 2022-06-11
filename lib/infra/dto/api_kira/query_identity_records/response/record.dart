import 'package:equatable/equatable.dart';

class Record extends Equatable {
  /// The address of identity record
  final String address;

  /// The identity record timestamp
  final DateTime date;

  /// The identity record id
  final String id;

  /// The identity record key
  final String key;

  /// The identity record value
  final String value;

  /// The address list of verifiers
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
      value: json['value'] as String,
      verifiers: json['verifiers'] != null
          ? (json['verifiers'] as List<dynamic>).map((dynamic e) => e as String).toList()
          : List<String>.empty(),
    );
  }

  @override
  String toString() {
    return 'Record{address: $address, date: $date, id: $id, key: $key, value: $value, verifiers: $verifiers}';
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
