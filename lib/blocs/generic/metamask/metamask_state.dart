part of 'metamask_cubit.dart';

class MetamaskState extends Equatable {
  final String? address;
  final int? chainId;
  final bool isLoadingBool;

  /// Explain to user why we need to sign a message using his Metamask account
  final bool needRequestForSignaturePermissionBool;

  const MetamaskState({
    this.address,
    this.chainId,
    this.isLoadingBool = false,
    this.needRequestForSignaturePermissionBool = false,
  });

  bool get hasData => chainId != null && address != null;

  // NOTE: The rest of the properties are nullable, so copyWith is not applicable
  MetamaskState copyWithBool({
    bool? isLoadingBool,
    bool? needRequestForSignaturePermissionBool,
  }) {
    return MetamaskState(
      isLoadingBool: isLoadingBool ?? this.isLoadingBool,
      address: address,
      chainId: chainId,
      needRequestForSignaturePermissionBool:
          needRequestForSignaturePermissionBool ?? this.needRequestForSignaturePermissionBool,
    );
  }

  @override
  List<Object?> get props => <Object?>[address, chainId, isLoadingBool, needRequestForSignaturePermissionBool];
}
