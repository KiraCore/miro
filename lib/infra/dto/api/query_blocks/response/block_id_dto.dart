import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_blocks/response/parts.dart';

class BlockIdDto extends Equatable {
  final String hash;
  final Parts parts;

  const BlockIdDto({required this.hash, required this.parts});

  factory BlockIdDto.fromJson(Map<String, dynamic> json) => BlockIdDto(
        hash: json['hash'] as String,
        parts: Parts.fromJson(json['parts'] as Map<String, dynamic>),
      );

  @override
  List<Object?> get props => <Object?>[hash, parts];
}
