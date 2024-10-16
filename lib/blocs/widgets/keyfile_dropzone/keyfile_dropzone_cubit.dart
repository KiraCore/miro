import 'dart:convert';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class KeyfileDropzoneCubit extends Cubit<KeyfileDropzoneState> {
  KeyfileDropzoneCubit() : super(KeyfileDropzoneState.empty());

  Future<void> uploadFileViaHtml(dynamic htmlFile) async {
    if (htmlFile is html.File) {
      updateSelectedFile(await FileModel.fromHtmlFile(htmlFile));
    } else {
      AppLogger().log(message: 'Unsupported file type ${htmlFile.runtimeType}');
    }
  }

  Future<void> uploadFileManually() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (filePickerResult == null) {
      return;
    }
    PlatformFile platformFile = filePickerResult.files.single;
    if (platformFile.bytes == null) {
      return;
    }

    updateSelectedFile(FileModel.fromPlatformFile(platformFile));
  }

  void updateSelectedFile(FileModel fileModel) {
    try {
      Map<String, dynamic> keyfileJson = jsonDecode(fileModel.content) as Map<String, dynamic>;
      AKeyfileEntity keyfileEntity = AKeyfileEntity.fromJson(keyfileJson);
      AEncryptedKeyfileModel encryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(keyfileEntity);
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
