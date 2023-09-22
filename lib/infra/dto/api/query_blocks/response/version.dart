import 'package:equatable/equatable.dart';

class Version extends Equatable {
  final String block;

  const Version({
    required this.block,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(block: json['block'] as String);

  @override
  List<Object?> get props => <Object?>[block];
}
