import 'package:flutter/cupertino.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_qr_section.dart';
import 'package:miro/views/pages/dialog/widgets/message_previews/message_preview.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/filled_scroll_view.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TransactionRequestResultPage extends StatefulWidget {
  final UnsignedTransaction unsignedTransaction;

  const TransactionRequestResultPage({
    required this.unsignedTransaction,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionRequestResultPage();
}

class _TransactionRequestResultPage extends State<TransactionRequestResultPage> {
  final DialogQrSectionController dialogQrSectionController = DialogQrSectionController();

  @override
  Widget build(BuildContext context) {
    return FilledScrollView(
      child: ColumnRowSwapper(
        rowMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        columnMainAxisAlignment: MainAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        reversedMobile: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, right: 9),
            child: DialogCard(
              width: 541,
              height: ResponsiveWidget.isLargeScreen(context) ? 500 : null,
              title: 'Share QR',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DialogQrSection(
                    controller: dialogQrSectionController,
                    qrData: widget.unsignedTransaction.toJson(),
                    showActionButtons: false,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: KiraElevatedButton(
                          onPressed: () {
                            if (dialogQrSectionController.download != null) {
                              dialogQrSectionController.download!();
                            }
                          },
                          title: 'Download',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: KiraOutlinedButton(
                          onPressed: () {
                            if (dialogQrSectionController.copy != null) {
                              dialogQrSectionController.copy!();
                            }
                          },
                          title: 'Copy',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 9),
            child: DialogCard(
              width: 541,
              height: ResponsiveWidget.isLargeScreen(context) ? 500 : null,
              title: 'Request details',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MessagePreview(
                    transaction: widget.unsignedTransaction,
                    fee: widget.unsignedTransaction.fee,
                    memo: widget.unsignedTransaction.memo,
                    message: widget.unsignedTransaction.messages.single,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
