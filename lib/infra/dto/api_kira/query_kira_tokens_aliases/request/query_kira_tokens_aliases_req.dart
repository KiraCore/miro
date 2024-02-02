import 'package:equatable/equatable.dart';

class QueryKiraTokensAliasesReq extends Equatable {
  final List<String>? tokens;
  final int? limit;
  final int? offset;

  const QueryKiraTokensAliasesReq({
    this.tokens,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> get queryParameters => <String, dynamic>{
        'tokens': tokens?.join(','),
        'limit': limit,
        'offset': offset,
      };

  @override
  List<Object?> get props => <Object?>[tokens, limit, offset];
}
