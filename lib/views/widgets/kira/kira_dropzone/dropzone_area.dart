import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_area_controller.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';

class DropzoneArea extends StatefulWidget {
  final DropzoneAreaController controller;
  final ValueChanged<DropzoneFile>? onPickFile;
  final ValueChanged<String?>? onError;
  final VoidCallback? onHover;
  final VoidCallback? onLeave;

  const DropzoneArea({
    required this.controller,
    this.onPickFile,
    this.onError,
    this.onHover,
    this.onLeave,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropzoneArea();
}

class _DropzoneArea extends State<DropzoneArea> {
  late DropzoneViewController dropzoneViewController;

  @override
  void initState() {
    _initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropzoneView(
      operation: DragOperation.all,
      cursor: CursorType.grab,
      onCreated: (DropzoneViewController controller) => dropzoneViewController = controller,
      onError: widget.onError,
      onHover: widget.onHover,
      onDrop: _onDropzoneDrop,
      onLeave: widget.onLeave,
    );
  }

  void _initController() {
    widget.controller.initController(
      pickFile: _pickFileManual,
    );
  }

  Future<DropzoneFile?> _pickFileManual() async {
    FilePickerResult? uploadResult = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (uploadResult != null) {
      PlatformFile platformFile = uploadResult.files.single;
      if (platformFile.bytes == null) {
        return null;
      }
      DropzoneFile file = DropzoneFile(
        name: platformFile.name,
        size: platformFile.size,
        extension: platformFile.extension,
        content: String.fromCharCodes(platformFile.bytes!),
      );
      _setFile(file);
      return file;
    }
    return null;
  }

  void _onDropzoneDrop(dynamic uploadedFile) {
    if (uploadedFile is html.File) {
      final html.FileReader reader = html.FileReader()..readAsText(uploadedFile);
      reader.onLoadEnd.listen((html.ProgressEvent event) {
        String result = reader.result.toString();
        DropzoneFile file = DropzoneFile(
          name: uploadedFile.name,
          size: uploadedFile.size,
          extension: uploadedFile.name.split('.').last,
          content: result,
        );
        _setFile(file);
      });
    }
  }

  void _setFile(DropzoneFile file) {
    widget.controller.currentFile = file;
    if (widget.onPickFile != null) {
      widget.onPickFile!(file);
    }
    widget.controller.notifyFileUpdated();
  }
}
