import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/buttons/timed_refresh_button/timed_refresh_button_cubit.dart';
import 'package:miro/blocs/widgets/buttons/timed_refresh_button/timed_refresh_button_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';

class TimedRefreshButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool disabledBool;
  final DateTime? expirationDateTime;

  const TimedRefreshButton({
    required this.onPressed,
    this.disabledBool = false,
    this.expirationDateTime,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimedRefreshButton();
}

class _TimedRefreshButton extends State<TimedRefreshButton> {
  final TimedRefreshButtonCubit timedRefreshButtonCubit = TimedRefreshButtonCubit();

  @override
  void initState() {
    super.initState();
    if (widget.expirationDateTime != null) {
      timedRefreshButtonCubit.startCounting(widget.expirationDateTime!);
    }
  }

  @override
  void didUpdateWidget(covariant TimedRefreshButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expirationDateTime != null) {
      timedRefreshButtonCubit.startCounting(widget.expirationDateTime!);
    }
  }

  @override
  void dispose() {
    timedRefreshButtonCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TimedRefreshButtonCubit, TimedRefreshButtonState>(
      bloc: timedRefreshButtonCubit,
      builder: (BuildContext context, TimedRefreshButtonState timedRefreshButtonState) {
        bool unlockedBool = timedRefreshButtonState.isUnlocked;
        bool activeBool = unlockedBool && widget.disabledBool == false;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: activeBool ? widget.onPressed : null,
              icon: Icon(
                Icons.refresh,
                size: 14,
                color: activeBool ? DesignColors.white1 : DesignColors.grey1,
              ),
              label: Text(
                unlockedBool || widget.disabledBool
                    ? S.of(context).refresh
                    : S.of(context).refreshInSeconds(timedRefreshButtonState.remainingUnlockTime.inSeconds),
                style: textTheme.bodySmall!.copyWith(
                  color: activeBool ? DesignColors.white1 : DesignColors.grey1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
