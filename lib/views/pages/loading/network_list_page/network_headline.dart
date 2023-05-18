import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';

class NetworkHeadline extends StatefulWidget {
  final TextStyle textStyle;

  const NetworkHeadline({
    required this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<NetworkHeadline> createState() => _NetworkHeadlineState();
}

class _NetworkHeadlineState extends State<NetworkHeadline> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkModuleBloc, NetworkModuleState>(
      bloc: globalLocator<NetworkModuleBloc>(),
      builder: (_, NetworkModuleState networkModuleState) {
        bool connectionCanceledBool = networkModuleState.isDisconnected;
        if (connectionCanceledBool) {
          return Text(
            S.of(context).networkConnectionCancelled,
            textAlign: TextAlign.center,
            style: widget.textStyle,
          );
        } else {
          return Text(
            S.of(context).networkConnectionEstablished,
            textAlign: TextAlign.center,
            style: widget.textStyle,
          );
        }
      },
    );
  }
}
