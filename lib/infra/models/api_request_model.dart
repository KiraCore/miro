import 'package:equatable/equatable.dart';

class ApiRequestModel<T> extends Equatable {
  final T requestData;
  final Uri networkUri;
  final bool forceRequestBool;

  const ApiRequestModel({
    required this.requestData,
    required this.networkUri,
    this.forceRequestBool = false,
  });

  @override
  List<Object?> get props => <Object?>[requestData, networkUri, forceRequestBool];
}
