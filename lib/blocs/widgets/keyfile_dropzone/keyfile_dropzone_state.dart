import 'package:equatable/equatable.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';

class KeyfileDropzoneState extends Equatable {
  final AEncryptedKeyfileModel? encryptedKeyfileModel;
  final FileModel? fileModel;
  final KeyfileExceptionType? keyfileExceptionType;

  const KeyfileDropzoneState({
    this.encryptedKeyfileModel,
    this.fileModel,
    this.keyfileExceptionType,
  });

  factory KeyfileDropzoneState.empty() {
    return const KeyfileDropzoneState();
  }

  bool get hasFile => fileModel != null;

  bool get hasKeyfile => encryptedKeyfileModel != null;

  @override
  List<Object?> get props => <Object?>[encryptedKeyfileModel, fileModel, keyfileExceptionType];
}
