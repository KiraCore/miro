import 'package:equatable/equatable.dart';

class QueryAccountReq extends Equatable {
  final String address;

  const QueryAccountReq({
    required this.address,
  });

  @override
  List<Object?> get props => <Object?>[address];
}
