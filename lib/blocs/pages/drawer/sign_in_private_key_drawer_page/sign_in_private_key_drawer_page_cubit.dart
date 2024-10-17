import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

part 'sign_in_private_key_drawer_page_state.dart';

class SignInPrivateKeyDrawerPageCubit extends Cubit<ASignInPrivateKeyDrawerPageState> {
  static int ethereumPrivateKeyLength = 64;

  final AuthCubit _authCubit;

  SignInPrivateKeyDrawerPageCubit()
      : _authCubit = globalLocator<AuthCubit>(),
        super(const SignInPrivateKeyDrawerPageInitialState());

  void handleKeyChanged() {
    emit(const SignInPrivateKeyDrawerPageInitialState());
  }

  Future<void> submitKey(String ethereumPrivateKey) async {
    try {
      Wallet wallet = Wallet.fromEthereumPrivateKey(ethereumPrivateKey);

      await _authCubit.signIn(wallet);

      emit(const SignInPrivateKeyDrawerPageSuccessState());
    } catch (e) {
      AppLogger().log(message: 'Error on private key parsing: $e', logLevel: LogLevel.error);
      emit(const SignInPrivateKeyDrawerPageErrorState());
    }
  }
}
