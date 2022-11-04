import 'package:equatable/equatable.dart';

class QueryExecutionFeeRequest extends Equatable {
  final String message;

  const QueryExecutionFeeRequest({
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
    };
  }

  @override
  List<Object?> get props => <Object?>[message];
}
