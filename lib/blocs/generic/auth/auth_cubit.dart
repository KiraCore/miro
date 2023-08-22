import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/token_storage/token_storage_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class AuthCubit extends Cubit<Wallet?> {
  final NetworkModuleBloc _networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final IdentityRegistrarCubit identityRegistrarCubit = globalLocator<IdentityRegistrarCubit>();
  final TokenStorageCubit _tokenStorageCubit = globalLocator<TokenStorageCubit>();

  AuthCubit() : super(null) {
    _networkModuleBloc.stream.listen((_) => _handleNetworkUpdated());
  }

  Future<void> signIn(Wallet wallet) async {
    emit(wallet);
    await identityRegistrarCubit.setWalletAddress(wallet.address);
  }

  Future<void> signOut() async {
    emit(null);
    await identityRegistrarCubit.setWalletAddress(null);
  }

  Future<void> _handleNetworkUpdated() async {
    if (state != null) {
      String bech32Hrp = await _tokenStorageCubit.getBech32Prefix();
      Wallet wallet = state!.copyWith(
        walletAddress: WalletAddress(
          addressBytes: state!.address.addressBytes,
          bech32Hrp: bech32Hrp,
        ),
      );
      emit(wallet);
      await identityRegistrarCubit.setWalletAddress(wallet.address);
    }
  }

  bool get isSignedIn => state != null;
}
