import 'package:equatable/equatable.dart';

class QueryFaucetReq extends Equatable {
  final String claimAddress;
  final String token;

  const QueryFaucetReq({
    required this.claimAddress,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'claim': claimAddress,
      'token': token,
    };
  }

  @override
  List<Object?> get props => <Object>[claimAddress, token];
}
