part of 'metamask_cubit.dart';

class MetamaskState extends Equatable {
  final String? address;
  final int? chainId;

  const MetamaskState({
    this.address,
    this.chainId,
  });

  bool get isConnected => chainId != null && address != null;

  @override
  List<Object?> get props => <Object?>[address, chainId];
}
