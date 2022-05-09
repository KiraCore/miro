import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/views/pages/dialog/dio_error_explorer_dialog.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/text_link.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

class BroadcastException {
  final DioError? dioError;
  final String? _type;
  final String? _message;
  final bool _showExplorer;

  BroadcastException({
    String? type,
    String? message,
    bool showExplorer = false,
    this.dioError,
  })  : _message = message,
        _type = type,
        _showExplorer = showExplorer;

  String get message {
    return _message != null ? _message![0].toUpperCase() + _message!.substring(1, _message!.length) : '';
  }

  String get type {
    return _type != null ? _type!.toUpperCase().replaceAll(' ', '_') : 'UNKNOWN_ERROR';
  }

  bool get showExplorer {
    return _showExplorer && dioError != null;
  }
}

class TransactionBroadcastPage extends StatefulWidget {
  final SignedTransaction signedTransaction;

  const TransactionBroadcastPage({
    required this.signedTransaction,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionBroadcastPage();
}

class _TransactionBroadcastPage extends State<TransactionBroadcastPage> {
  bool loadingStatus = true;
  BroadcastException? broadcastException;
  BroadcastResp? broadcastResp;

  @override
  void initState() {
    _broadcastTransaction();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _getCurrentView(),
      ),
    );
  }

  Future<void> _broadcastTransaction() async {
    _setLoadingStatus(status: true);
    try {
      broadcastResp = await globalLocator<TransactionsService>().broadcastTransaction(widget.signedTransaction);
    } catch (e) {
      _handleBroadcastException(e);
    }
    _setLoadingStatus(status: false);
  }

  void _handleBroadcastException(Object object) {
    Object exception = object;
    if (exception is DioError && exception.response?.data is Map) {
      final Map<String, dynamic> response = exception.response!.data as Map<String, dynamic>;
      if (response['data'] != null) {
        broadcastException = BroadcastException(
          dioError: exception,
          type: exception.response?.statusMessage,
          message: response['data']! as String,
          showExplorer: true,
        );
      } else if (response['check_tx'] != null) {
        String fullErrorMessage = response['check_tx']!['log'] as String;
        String errorMessage = fullErrorMessage.split('\n').last;
        broadcastException = BroadcastException(
          dioError: exception,
          type: 'TRANSACTION_ERROR',
          message: errorMessage,
          showExplorer: true,
        );
      } else if (<DioErrorType>[DioErrorType.connectTimeout, DioErrorType.receiveTimeout, DioErrorType.sendTimeout]
          .contains(exception.type)) {
        broadcastException = BroadcastException(
          dioError: exception,
          type: 'NETWORK_ERROR',
          message: 'Cannot broadcast transaction. Check internet connection',
        );
      }
    } else {
      broadcastException = BroadcastException(
        type: 'PARSE_ERROR',
        message: 'Cannot parse response',
      );
    }
  }

  void _setLoadingStatus({required bool status}) {
    if (loadingStatus != status) {
      setState(() {
        loadingStatus = status;
      });
    }
  }

  Widget _getCurrentView() {
    if (loadingStatus) {
      return _BroadcastingTransactionView();
    } else if (broadcastException == null && broadcastResp != null) {
      return _SuccessTransactionView(broadcastResp: broadcastResp!);
    } else {
      return _ErrorTransactionView(
        broadcastException: broadcastException!,
        onTransactionRetry: _broadcastTransaction,
      );
    }
  }
}

class _BroadcastingTransactionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          Assets.assetsLogoLoading,
          height: 61,
          width: 61,
        ),
        const SizedBox(height: 30),
        const Text(
          'Your transaction is being verified',
          style: TextStyle(
            color: DesignColors.white_100,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'It might take up to 30 seconds. Do not close this window',
          style: TextStyle(
            color: DesignColors.gray2_100,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}

class _SuccessTransactionView extends StatelessWidget {
  final BroadcastResp broadcastResp;

  const _SuccessTransactionView({
    required this.broadcastResp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const _StatusIcon(
          size: 57,
          color: DesignColors.green,
          icon: Icon(
            AppIcons.done,
            color: DesignColors.white_100,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Transaction completed',
          style: TextStyle(
            color: DesignColors.white_100,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              'Transaction hash: ${broadcastResp.hash}',
              style: const TextStyle(
                color: DesignColors.gray2_100,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: broadcastResp.hash));
                KiraToast.show('Copied: ${broadcastResp.hash}');
              },
              icon: const Icon(
                AppIcons.copy,
                color: DesignColors.gray2_100,
              ),
            ),
          ],
        ),
        const SizedBox(height: 41),
        KiraOutlinedButton(
          width: 163,
          height: 51,
          onPressed: () {
            AutoRouter.of(context).root.pop();
          },
          title: 'Back to profile',
        ),
      ],
    );
  }
}

class _ErrorTransactionView extends StatelessWidget {
  final void Function() onTransactionRetry;
  final BroadcastException broadcastException;

  const _ErrorTransactionView({
    required this.broadcastException,
    required this.onTransactionRetry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const _StatusIcon(
          size: 57,
          color: DesignColors.red_100,
          icon: Icon(
            AppIcons.cancel,
            color: DesignColors.white_100,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Transaction failed',
          style: TextStyle(
            color: DesignColors.white_100,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '<${broadcastException.type}> ${broadcastException.message}',
          style: const TextStyle(
            color: DesignColors.gray2_100,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        if (broadcastException.showExplorer)
          TextLink(
            'See more on explorer',
            onTap: () {
              showDialog<void>(
                context: context,
                useRootNavigator: false,
                builder: (_) => DioErrorExplorerDialog(dioError: broadcastException.dioError!),
              );
            },
          ),
        const SizedBox(height: 41),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            KiraOutlinedButton(
              width: 163,
              height: 51,
              onPressed: () {
                AutoRouter.of(context).root.pop();
              },
              title: 'Back to profile',
            ),
            const SizedBox(width: 12),
            KiraOutlinedButton(
              width: 163,
              height: 51,
              onPressed: onTransactionRetry,
              title: 'Try again',
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color color;

  const _StatusIcon({
    required this.icon,
    required this.size,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: color,
        radius: size / 2,
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
