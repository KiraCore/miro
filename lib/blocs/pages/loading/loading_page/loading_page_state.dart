import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

abstract class ALoadingPageState extends Equatable {
  final ANetworkStatusModel? networkStatusModel;

  const ALoadingPageState({
    this.networkStatusModel,
  });

  @override
  List<Object?> get props => <Object?>[networkStatusModel];
}
