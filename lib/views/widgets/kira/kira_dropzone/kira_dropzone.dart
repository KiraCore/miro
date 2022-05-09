import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/text_link.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/dropzone_area.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_area_controller.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/dropzone_file.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/models/kira_dropzone_controller.dart';

class KiraDropzone extends StatefulWidget {
  final KiraDropzoneController controller;
  final ValidateDropzoneFile validate;
  final double width;
  final double height;
  final String title;

  const KiraDropzone({
    required this.controller,
    required this.validate,
    required this.title,
    this.width = double.infinity,
    this.height = 128,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraDropzone();
}

class _KiraDropzone extends State<KiraDropzone> {
  final DropzoneAreaController dropzoneAreaController = DropzoneAreaController();
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
          color: errorMessage != null ? DesignColors.red_100 : DesignColors.blue1_100,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: DropzoneArea(
              controller: dropzoneAreaController,
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
      dropzoneAreaController: dropzoneAreaController,
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
        Text(widget.title),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text('or '),
            TextLink(
              'browse',
              onTap: () {
                dropzoneAreaController.pickFile();
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
                  style: const TextStyle(color: DesignColors.red_100),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
