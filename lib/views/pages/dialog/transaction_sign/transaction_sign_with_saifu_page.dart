import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/transaction_sign_request.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_qr_section.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/kira/kira_checkbox_list_tile.dart';

class TransactionSignWithSaifuPage extends StatefulWidget {
  final UnsignedTransaction unsignedTransaction;

  const TransactionSignWithSaifuPage({required this.unsignedTransaction, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionSignWithSaifuPage();
}

class _TransactionSignWithSaifuPage extends State<TransactionSignWithSaifuPage> {
  final ValueNotifier<bool> _termsCheckedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogCard(
        title: 'Sign transaction with Saifu',
        subtitle: 'Open Saifu app to scan the qr code',
        trailing: _SaifuIcon(),
        child: FutureBuilder<TransactionNetworkData>(
          future: globalLocator<TransactionsService>().getTransactionNetworkData(),
          builder: (BuildContext context, AsyncSnapshot<TransactionNetworkData> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: CenterLoadSpinner(),
              );
            }

            TransactionSignRequest transactionSignRequest = TransactionSignRequest(
              unsignedTransaction: widget.unsignedTransaction,
              networkData: snapshot.data!,
            );

            return Column(
              children: <Widget>[
                DialogQrSection(
                  qrData: transactionSignRequest.toJson(),
                ),
                const SizedBox(height: 30),
                KiraCheckboxListTile(
                  onChanged: (bool value) {
                    _termsCheckedNotifier.value = value;
                  },
                  title: 'I confirm that I scan and verify the transaction in Sauifu app ',
                ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    ValueListenableBuilder<bool>(
                      valueListenable: _termsCheckedNotifier,
                      builder: (_, bool value, __) => KiraElevatedButton(
                        width: 82,
                        height: 51,
                        disabled: !value,
                        onPressed: () {
                          AutoRouter.of(context).push(
                            TransactionScanRoute(transactionSignRequest: transactionSignRequest),
                          );
                        },
                        title: 'Next',
                      ),
                    ),
                    const SizedBox(width: 8),
                    KiraOutlinedButton(
                      width: 82,
                      height: 51,
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                      title: 'Back',
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SaifuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: DesignColors.blue1_20,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SvgPicture.asset(Assets.iconsSaifuSymbol),
      ),
    );
  }
}
