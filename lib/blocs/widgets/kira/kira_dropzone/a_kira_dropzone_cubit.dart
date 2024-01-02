import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_state.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class AKiraDropzoneCubit<T extends AKiraDropzoneState> extends Cubit<T> {
  AKiraDropzoneCubit(T state) : super(state);

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

  void updateSelectedFile(FileModel fileModel);
}
