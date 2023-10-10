import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/tx_broadcast_cubit.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_complete_body.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_error_body.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_loading_body.dart';

class TxBroadcastPage<T extends AMsgFormModel> extends StatefulWidget {
  final SignedTxModel signedTxModel;

  const TxBroadcastPage({
    required this.signedTxModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxBroadcastPage<T>();
}

class _TxBroadcastPage<T extends AMsgFormModel> extends State<TxBroadcastPage<T>> {
  final TxBroadcastCubit txBroadcastCubit = TxBroadcastCubit();

  @override
  void initState() {
    super.initState();
    txBroadcastCubit.broadcast(widget.signedTxModel);
  }

  @override
  void dispose() {
    txBroadcastCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TxBroadcastCubit>.value(
      value: txBroadcastCubit,
      child: BlocBuilder<TxBroadcastCubit, ATxBroadcastState>(
        builder: (BuildContext context, ATxBroadcastState txBroadcastState) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildTxStatusWidget(txBroadcastState),
          );
        },
      ),
    );
  }

  Widget _buildTxStatusWidget(ATxBroadcastState txBroadcastState) {
    if (txBroadcastState is TxBroadcastErrorState) {
      return TxBroadcastErrorBody<T>(
        errorExplorerModel: txBroadcastState.errorExplorerModel,
        signedTxModel: widget.signedTxModel,
      );
    } else if (txBroadcastState is TxBroadcastLoadingState) {
      return TxBroadcastLoadingBody(txBroadcastLoadingState: txBroadcastState);
    } else if (txBroadcastState is TxBroadcastCompletedState) {
      return TxBroadcastCompleteBody(txBroadcastCompletedState: txBroadcastState);
    } else {
      AppLogger().log(message: 'Unexpected ATxBroadcastState state $txBroadcastState', logLevel: LogLevel.fatal);
      return const SizedBox();
    }
  }
}
