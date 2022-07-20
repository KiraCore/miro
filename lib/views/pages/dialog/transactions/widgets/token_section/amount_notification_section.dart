import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class AmountNotificationSection extends StatelessWidget {
  final bool loading;
  final TokenAmount? maxTokenAmount;
  final String? errorMessage;

  const AmountNotificationSection({
    this.loading = false,
    this.maxTokenAmount,
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color messageColor = DesignColors.darkGreen_100;
    if (errorMessage != null) {
      messageColor = DesignColors.red_100;
    }

    if (loading) {
      return Row(
        children: const <Widget>[
          CenterLoadSpinner(size: 10),
          SizedBox(width: 8),
          Text(
            'Loading balances...',
            style: TextStyle(
              color: DesignColors.gray2_100,
              fontSize: 12,
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: TextStyle(
              fontSize: 12,
              color: messageColor,
            ),
          ),
        if (notificationMessage != null)
          Text(
            notificationMessage!,
            style: TextStyle(
              color: messageColor,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  String? get notificationMessage {
    if (maxTokenAmount != null) {
      return 'Max value: ${maxTokenAmount.toString()}';
    }
  }
}
