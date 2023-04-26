import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/token_rate.dart';

class QueryKiraTokensRatesResp extends Equatable {
  final List<TokenRate> data;

  const QueryKiraTokensRatesResp({
    required this.data,
  });

  factory QueryKiraTokensRatesResp.fromJson(Map<String, dynamic> json) {
    return QueryKiraTokensRatesResp(
      data: (json['data'] as List<dynamic>).map((dynamic e) => TokenRate.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[data];
}
