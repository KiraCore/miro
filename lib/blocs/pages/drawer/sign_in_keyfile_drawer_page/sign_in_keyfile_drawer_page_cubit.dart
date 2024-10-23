import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_state.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class SignInKeyfileDrawerPageCubit extends Cubit<SignInKeyfileDrawerPageState> {
  final AuthCubit authCubit;
  final KeyfileDropzoneCubit keyfileDropzoneCubit;
  final TextEditingController passwordTextEditingController;
  late final StreamSubscription<KeyfileDropzoneState> _keyfileDropzoneStateSubscription;

  SignInKeyfileDrawerPageCubit({
    required this.authCubit,
    required this.keyfileDropzoneCubit,
    required this.passwordTextEditingController,
  }) : super(const SignInKeyfileDrawerPageState()) {
    _keyfileDropzoneStateSubscription = keyfileDropzoneCubit.stream.listen(_listenKeyfileChange);
  }

  @override
  Future<void> close() {
    keyfileDropzoneCubit.close();
    _keyfileDropzoneStateSubscription.cancel();
    return super.close();
  }

  void notifyPasswordChanged() {
    if (state.keyfileExceptionType == KeyfileExceptionType.wrongPassword) {
      emit(state.copyWith(keyfileExceptionType: () => null));
    }
  }

  Future<void> _listenKeyfileChange(KeyfileDropzoneState keyfileDropzoneState) async {
    bool keyfileValidBool = keyfileDropzoneState.keyfileExceptionType == null;
    if (keyfileValidBool) {
      await _decryptKeyfile();
    } else {
      emit(state.copyWith(keyfileExceptionType: () => keyfileDropzoneState.keyfileExceptionType));
    }
  }

  Future<void> _decryptKeyfile({bool signInBool = false}) async {
    emit(state.copyWith(isLoadingBool: true));
    try {
      String password = passwordTextEditingController.text;
      AEncryptedKeyfileModel encryptedKeyfileModel = keyfileDropzoneCubit.state.encryptedKeyfileModel!;
      ADecryptedKeyfileModel decryptedKeyfileModel = await encryptedKeyfileModel.decrypt(password);
      if (signInBool) {
        Wallet wallet = decryptedKeyfileModel.keyfileSecretDataModel.wallet;
        await authCubit.signIn(wallet);
      }

      emit(SignInKeyfileDrawerPageState(signInSuccessBool: signInBool));
    } on KeyfileException catch (e) {
      AppLogger().log(message: 'Error on keyfile decryption: ${e.keyfileExceptionType}');
      emit(SignInKeyfileDrawerPageState(keyfileExceptionType: e.keyfileExceptionType));
    } catch (e) {
      AppLogger().log(message: 'Invalid keyfile: $e');
      emit(const SignInKeyfileDrawerPageState(keyfileExceptionType: KeyfileExceptionType.invalidKeyfile));
    }
  }

  void signIn() {
    _decryptKeyfile(signInBool: true);
  }
}
