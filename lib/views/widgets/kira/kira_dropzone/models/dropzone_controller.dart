import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';

typedef FilePickedCallback = Future<DropzoneFile?> Function();

class KiraDropzoneController {
  late FilePickedCallback pickFile;
  DropzoneFile? currentFile;

  void initController({
    required FilePickedCallback pickFile,
  }) {
    this.pickFile = pickFile;
  }
}
