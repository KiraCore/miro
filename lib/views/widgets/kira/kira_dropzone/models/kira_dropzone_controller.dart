import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_area_controller.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';

typedef ValidateDropzoneFile = String? Function(DropzoneFile?);

class KiraDropzoneController {
  late DropzoneAreaController dropzoneAreaController;
  late void Function(String?) setErrorMessage;
  late String? Function() validate;

  void initController({
    required DropzoneAreaController dropzoneAreaController,
    required String? Function() validate,
    required void Function(String?) setErrorMessage,
  }) {
    this.dropzoneAreaController = dropzoneAreaController;
    this.validate = validate;
    this.setErrorMessage = setErrorMessage;
  }
}
