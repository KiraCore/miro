import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/tx_broadcast_cubit.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_complete_body.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_error_body.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_loading_body.dart';

class TxBroadcastPage extends StatefulWidget {
  final String? txFormPageName;
  final SignedTxModel? signedTxModel;

  const TxBroadcastPage({
    @QueryParam('txFormPageName') this.txFormPageName,
    @QueryParam('tx') this.signedTxModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxBroadcastPage();
}

class _TxBroadcastPage extends State<TxBroadcastPage> {
  final TxBroadcastCubit txBroadcastCubit = TxBroadcastCubit();

  @override
  void initState() {
    super.initState();
    if (widget.signedTxModel != null) {
      txBroadcastCubit.broadcast(widget.signedTxModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.signedTxModel == null) {
      KiraRouter.of(context).navigateBack();
    }

    return BlocProvider<TxBroadcastCubit>(
      create: (_) => txBroadcastCubit,
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
      return TxBroadcastErrorBody(
        txFormPageName: widget.txFormPageName,
        errorExplorerModel: txBroadcastState.errorExplorerModel,
        signedTxModel: widget.signedTxModel!,
      );
    } else if (txBroadcastState is TxBroadcastLoadingState) {
      return TxBroadcastLoadingBody(txBroadcastLoadingState: txBroadcastState);
    } else if (txBroadcastState is TxBroadcastCompletedState) {
      return TxBroadcastCompleteBody(txBroadcastCompletedState: txBroadcastState);
    } else {
      AppLogger().log(message: 'Unexpected ATxBroadcastState state $txBroadcastState', logLevel: LogLevel.terribleFailure);
      return const SizedBox();
    }
  }
}
