import 'package:equatable/equatable.dart';

class ApiRequestModel<T> extends Equatable {
  final Uri networkUri;
  final T requestData;

  const ApiRequestModel({
    required this.networkUri,
    required this.requestData,
  });

  @override
  List<Object?> get props => <Object?>[networkUri, requestData];
}
