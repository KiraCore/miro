import 'package:equatable/equatable.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';

class SignInKeyfileDrawerPageState extends Equatable {
  final KeyfileExceptionType? keyfileExceptionType;
  final ADecryptedKeyfileModel? decryptedKeyfileModel;
  final bool isLoading;

  const SignInKeyfileDrawerPageState({
    this.keyfileExceptionType,
    this.decryptedKeyfileModel,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => <Object?>[keyfileExceptionType, decryptedKeyfileModel, isLoading];
}
