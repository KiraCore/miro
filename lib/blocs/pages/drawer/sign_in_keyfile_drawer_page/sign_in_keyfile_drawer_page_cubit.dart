import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_state.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/infra/factory/keyfile_factory.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/models/keyfile/decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';

class SignInKeyfileDrawerPageCubit extends Cubit<SignInKeyfileDrawerPageState> {
  final KeyfileDropzoneCubit keyfileDropzoneCubit;
  final TextEditingController passwordTextEditingController;
  final KeyfileFactory _keyfileFactory = KeyfileFactory();
  late final StreamSubscription<KeyfileDropzoneState> _keyfileDropzoneStateSubscription;

  SignInKeyfileDrawerPageCubit({
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
    bool keyfileUploadedBool = keyfileDropzoneCubit.state.hasKeyfile;
    if (keyfileUploadedBool) {
      _decryptKeyfile();
    }
  }

  void _listenKeyfileChange(KeyfileDropzoneState keyfileDropzoneState) {
    bool keyfileInvalidBool = keyfileDropzoneState.keyfileExceptionType != null;
    if (keyfileInvalidBool) {
      emit(SignInKeyfileDrawerPageState(keyfileExceptionType: keyfileDropzoneState.keyfileExceptionType));
    } else {
      _decryptKeyfile();
    }
  }

  void _decryptKeyfile() {
    try {
      String password = passwordTextEditingController.text;
      EncryptedKeyfileModel encryptedKeyfileModel = keyfileDropzoneCubit.state.encryptedKeyfileModel!;
      DecryptedKeyfileModel decryptedKeyfileModel = _keyfileFactory.decryptKeyfileModel(encryptedKeyfileModel, password);

      emit(SignInKeyfileDrawerPageState(decryptedKeyfileModel: decryptedKeyfileModel));
    } on KeyfileException catch (e) {
      emit(SignInKeyfileDrawerPageState(keyfileExceptionType: e.keyfileExceptionType));
    }
  }
}
