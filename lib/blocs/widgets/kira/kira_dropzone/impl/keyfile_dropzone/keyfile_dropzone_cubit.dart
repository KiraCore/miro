import 'dart:convert';

import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/infra/factory/keyfile_factory.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class KeyfileDropzoneCubit extends AKiraDropzoneCubit<KeyfileDropzoneState> {
  final KeyfileFactory _keyfileFactory = KeyfileFactory();

  KeyfileDropzoneCubit() : super(KeyfileDropzoneState.empty());

  @override
  void updateSelectedFile(FileModel fileModel) {
    try {
      Map<String, dynamic> keyfileJson = jsonDecode(fileModel.content) as Map<String, dynamic>;
      EncryptedKeyfileModel encryptedKeyfileModel = _keyfileFactory.buildEncryptedKeyfileFromJson(keyfileJson);
      emit(KeyfileDropzoneState(encryptedKeyfileModel: encryptedKeyfileModel, fileModel: fileModel));
    } on KeyfileException catch (keyfileException) {
      AppLogger().log(message: keyfileException.keyfileExceptionType.toString());
      emit(KeyfileDropzoneState(keyfileExceptionType: keyfileException.keyfileExceptionType, fileModel: fileModel));
    } catch (e) {
      AppLogger().log(message: 'Invalid keyfile: $e');
      emit(KeyfileDropzoneState(keyfileExceptionType: KeyfileExceptionType.invalidKeyfile, fileModel: fileModel));
    }
  }
}
