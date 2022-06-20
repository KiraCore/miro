import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_controller.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';

typedef ValidateKeyfileCallback = String? Function(DropzoneFile?);

class KeyfileDropzoneController {
  late KiraDropzoneController dropzoneController;
  late String? Function() validate;
  late void Function(String?) setErrorMessage;

  void initController({
    required KiraDropzoneController dropzoneController,
    required String? Function() validate,
    required void Function(String?) setErrorMessage,
  }) {
    this.dropzoneController = dropzoneController;
    this.validate = validate;
    this.setErrorMessage = setErrorMessage;
  }
}
