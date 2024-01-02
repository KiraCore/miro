import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_state.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';

class KeyfileDropzoneState extends AKiraDropzoneState {
  final EncryptedKeyfileModel? encryptedKeyfileModel;
  final KeyfileExceptionType? keyfileExceptionType;

  const KeyfileDropzoneState({
    FileModel? fileModel,
    this.encryptedKeyfileModel,
    this.keyfileExceptionType,
  }) : super(fileModel: fileModel);

  factory KeyfileDropzoneState.empty() {
    return const KeyfileDropzoneState();
  }
  
  bool get hasKeyfile => encryptedKeyfileModel != null;

  @override
  List<Object?> get props => <Object?>[fileModel, encryptedKeyfileModel, keyfileExceptionType];
}
