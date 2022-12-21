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
    super.initState();
    _initController();
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
            child: KiraDropzone(
              controller: dropZoneController,
              onHover: () => _setHoverState(status: true),
              onLeave: () => _setHoverState(status: false),
              onPickFile: _onFilePicked,
            ),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: () => dropZoneController.pickFile(),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: _buildPreview(),
              ),
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        'Drop file'.toUpperCase(),
        style: textTheme.bodyText2!.copyWith(color: DesignColors.blue1_100),
      ),
    );
  }

  Widget _buildEmptyPreview() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Please drop Keyfile here',
          style: textTheme.bodyText2!.copyWith(
            color: DesignColors.gray3_100,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              'or ',
              style: textTheme.bodyText2!.copyWith(
                color: DesignColors.gray3_100,
              ),
            ),
            TextLink(
              text: 'browse',
              textStyle: textTheme.bodyText2!,
              onTap: () => dropZoneController.pickFile(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilePreview() {
    TextTheme textTheme = Theme.of(context).textTheme;

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
                style: textTheme.bodyText2!.copyWith(
                  color: DesignColors.gray3_100,
                ),
              ),
              if (errorMessage == null)
                Text(
                  actualFile!.sizeString,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: DesignColors.gray2_100,
                  ),
                )
              else
                Text(
                  errorMessage!,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: DesignColors.red_100,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
