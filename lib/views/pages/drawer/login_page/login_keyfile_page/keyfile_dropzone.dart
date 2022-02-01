import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/keyfile_dropzone_controller.dart';
import 'package:miro/views/widgets/generic/text_link.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/kira_dropzone.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_controller.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';

class KeyfileDropzone extends StatefulWidget {
  final KeyfileDropzoneController controller;
  final ValidateKeyfile validate;
  final double width;
  final double height;

  const KeyfileDropzone({
    required this.controller,
    required this.validate,
    this.width = double.infinity,
    this.height = 128,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeyfileDropzone();
}

class _KeyfileDropzone extends State<KeyfileDropzone> {
  final KiraDropzoneController dropZoneController = KiraDropzoneController();
  bool isHover = false;
  DropzoneFile? actualFile;
  String? errorMessage;

  @override
  void initState() {
    _initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: errorMessage != null ? DesignColors.red : DesignColors.blue1_100,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: KiraDropzone(
              controller: dropZoneController,
              onHover: () => _setHoverState(status: true),
              onLeave: () => _setHoverState(status: false),
              onPickFile: _onFilePicked,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: _buildPreview(),
            ),
          ),
        ],
      ),
    );
  }

  void _initController() {
    widget.controller.initController(
      dropzoneController: dropZoneController,
      validate: _validate,
      setErrorMessage: _setErrorMessage,
    );
  }

  String? _validate() {
    errorMessage = widget.validate(actualFile);
    setState(() {});
    return errorMessage;
  }

  void _setErrorMessage(String? message) {
    setState(() {
      errorMessage = message;
    });
  }

  void _onFilePicked(DropzoneFile file) {
    _setHoverState(status: false);
    setState(() {
      errorMessage = widget.validate(file);
      actualFile = file;
    });
  }

  void _setHoverState({required bool status}) {
    setState(() {
      isHover = status;
    });
  }

  Widget _buildPreview() {
    if (isHover) {
      return _buildDropPreview();
    }
    if (actualFile == null) {
      return _buildEmptyPreview();
    }
    return _buildFilePreview();
  }

  Widget _buildDropPreview() {
    return Center(
      child: Text(
        'Drop file'.toUpperCase(),
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildEmptyPreview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text('Please drop a key file here'),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text('or '),
            TextLink(
              'browse',
              onTap: () {
                dropZoneController.pickFile();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilePreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.insert_drive_file,
          color: DesignColors.gray2_100,
          size: 50,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                actualFile!.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (errorMessage == null)
                Text(
                  actualFile!.sizeString,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: DesignColors.gray2_100),
                )
              else
                Text(
                  errorMessage!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: DesignColors.red),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
