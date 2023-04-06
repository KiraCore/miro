import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/error_explorer_model.dart';
import 'package:miro/views/widgets/generic/error_explorer_dialog/error_explorer_json_preview.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';

class ErrorExplorerDialog extends StatelessWidget {
  final ErrorExplorerModel errorExplorerModel;

  const ErrorExplorerDialog({
    required this.errorExplorerModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      maxWidth: 800,
      title: S.of(context).errorExplorer,
      subtitle: <String>[
        errorExplorerModel.code,
        if (errorExplorerModel.message != null) errorExplorerModel.message!,
      ],
      suffixWidget: IconButton(
        icon: const Icon(
          AppIcons.cancel,
          color: DesignColors.white1,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      child: Column(
        children: <Widget>[
          TxInputWrapper(
            child: Row(
              children: <Widget>[
                Text(
                  errorExplorerModel.method,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SelectableText(errorExplorerModel.uri.toString()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ColumnRowSwapper(
            expandOnRow: true,
            children: <Widget>[
              ErrorExplorerJsonPreview(
                title: S.of(context).txErrorHttpRequest,
                jsonObject: errorExplorerModel.request,
              ),
              const ColumnRowSpacer(size: 15),
              ErrorExplorerJsonPreview(
                title: S.of(context).txErrorHttpResponse,
                jsonObject: errorExplorerModel.response,
              ),
            ],
          )
        ],
      ),
    );
  }
}
