import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/pages/dialog/transactions/generic_transaction_page/generic_transaction_form.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/dialog_card.dart';

class GenericTransactionPage extends StatelessWidget {
  final String messageType;
  final Map<String, dynamic>? metadata;

  const GenericTransactionPage({
    @QueryParam('messageType') this.messageType = 'MsgSend',
    @QueryParam('metadata') this.metadata,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogCard(
        title: _getFormTitle(),
        child: FutureBuilder<String>(
          future: _fetchTransactionFee(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: CenterLoadSpinner(),
              );
            }

            if (snapshot.hasError) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('Cannot download required data'),
                ),
              );
            }

            return GenericTransactionForm(
              feeValue: snapshot.data!,
              messageType: messageType,
              metadata: metadata ?? <String, dynamic>{},
            );
          },
        ),
      ),
    );
  }

  String _getFormTitle() {
    Map<String, String> pageTitles = <String, String>{
      'MsgSend': 'Send tokens',
    };
    return pageTitles[messageType] ?? 'Unknown transaction';
  }

  Future<String> _fetchTransactionFee() async {
    // TODO(dominik): That's mocked value. Connect it with repository in the next steps
    return '100';
  }
}
