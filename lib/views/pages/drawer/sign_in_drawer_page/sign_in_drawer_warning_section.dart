import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/buttons/time_counter/time_counter_cubit.dart';
import 'package:miro/blocs/widgets/buttons/time_counter/time_counter_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class SignInDrawerWarningSection extends StatefulWidget {
  final bool refreshingBool;
  final VoidCallback changeNetworkButtonPressed;
  final DateTime? expirationDateTime;

  const SignInDrawerWarningSection({
    required this.refreshingBool,
    required this.changeNetworkButtonPressed,
    this.expirationDateTime,
    Key? key,
  }) : super(key: key);

  @override
  State<SignInDrawerWarningSection> createState() => _SignInDrawerWarningSectionState();
}

class _SignInDrawerWarningSectionState extends State<SignInDrawerWarningSection> {
  final TimeCounterCubit timeCounterCubit = TimeCounterCubit();

  @override
  void initState() {
    super.initState();
    if (widget.expirationDateTime != null) {
      timeCounterCubit.startCounting(widget.expirationDateTime!);
    }
  }

  @override
  void didUpdateWidget(covariant SignInDrawerWarningSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expirationDateTime != null) {
      timeCounterCubit.startCounting(widget.expirationDateTime!);
    }
  }

  @override
  void dispose() {
    timeCounterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TimeCounterCubit, TimeCounterState>(
      bloc: timeCounterCubit,
      builder: (BuildContext context, TimeCounterState timeCounterState) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (widget.refreshingBool) ...<Widget>[
                    const SizedBox(
                      height: 8,
                      width: 8,
                      child: CircularProgressIndicator(
                        color: DesignColors.grey1,
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    widget.refreshingBool ? '${S.of(context).connectWalletRefreshing}. ' : '${S.of(context).connectWalletRefreshed}. ',
                    style: textTheme.bodySmall!.copyWith(
                      color: DesignColors.grey1,
                    ),
                  ),
                  Text(
                    S.of(context).connectWalletRefreshInfo(timeCounterState.remainingUnlockTime.inSeconds),
                    style: textTheme.bodySmall!.copyWith(
                      color: DesignColors.grey1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Row(
              children: <Widget>[
                Expanded(
                  child: KiraOutlinedButton(
                    title: S.of(context).connectWalletButtonChangeNetwork,
                    onPressed: widget.changeNetworkButtonPressed,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
