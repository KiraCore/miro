import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/kira_dropzone_drop_view.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/kira_dropzone_empty_view.dart';

class KiraDropzone<T extends AKiraDropzoneState> extends StatefulWidget {
  final double width;
  final double height;
  final String emptyLabel;
  final AKiraDropzoneCubit<T> kiraDropzoneCubit;
  final Widget Function(AKiraDropzoneState kiraDropzoneState, String? errorMessage) filePreviewBuilder;
  final String? errorMessage;

  const KiraDropzone({
    required this.width,
    required this.height,
    required this.emptyLabel,
    required this.kiraDropzoneCubit,
    required this.filePreviewBuilder,
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraDropzone<T>();
}

class _KiraDropzone<T extends AKiraDropzoneState> extends State<KiraDropzone<T>> {
  bool hoverBool = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AKiraDropzoneCubit<T>, T>(
      builder: (BuildContext context, T kiraDropzoneState) {
        late Widget dropzonePreview;

        if (hoverBool) {
          dropzonePreview = const KiraDropzoneDropView();
        } else if (kiraDropzoneState.hasFile) {
          dropzonePreview = widget.filePreviewBuilder(kiraDropzoneState, widget.errorMessage);
        } else {
          dropzonePreview = KiraDropzoneEmptyView<T>(
            emptyLabel: widget.emptyLabel,
            kiraDropzoneCubit: widget.kiraDropzoneCubit,
          );
        }

        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: widget.errorMessage != null ? DesignColors.redStatus1 : DesignColors.white1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DropzoneView(
                  operation: DragOperation.all,
                  cursor: CursorType.grab,
                  onHover: () => _setHoverState(status: true),
                  onDrop: _listenFileDrop,
                  onLeave: () => _setHoverState(status: false),
                ),
              ),
              Positioned.fill(
                child: InkWell(
                  onTap: widget.kiraDropzoneCubit.uploadFileManually,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: dropzonePreview,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _listenFileDrop(dynamic file) {
    widget.kiraDropzoneCubit.uploadFileViaHtml(file);
    _setHoverState(status: false);
  }
  
  void _setHoverState({required bool status}) {
    hoverBool = status;
    setState(() {});
  }
}
