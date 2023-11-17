import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/a_staking_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/staking_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_loading_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_status_chip/staking_status_chip.dart';
import 'package:miro/views/widgets/generic/account_tile_copy_wrapper.dart';
import 'package:miro/views/widgets/generic/staking_pool_details_grid.dart';

class StakingDrawerPage extends StatefulWidget {
  final ValidatorStakingModel validatorStakingModel;

  const StakingDrawerPage({
    required this.validatorStakingModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingDrawerPage();
}

class _StakingDrawerPage extends State<StakingDrawerPage> {
  final StakingDrawerPageCubit stakingDrawerPageCubit = StakingDrawerPageCubit();
  late final ValidatorSimplifiedModel validatorSimplifiedModel = widget.validatorStakingModel.validatorSimplifiedModel;

  @override
  void initState() {
    stakingDrawerPageCubit.init(validatorSimplifiedModel.walletAddress);
    super.initState();
  }

  @override
  void dispose() {
    stakingDrawerPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<StakingDrawerPageCubit, AStakingDrawerPageState>(
      bloc: stakingDrawerPageCubit,
      builder: (BuildContext context, AStakingDrawerPageState stakingDrawerPageState) {
        bool errorBool = stakingDrawerPageState is StakingDrawerPageErrorState;
        bool loadingBool = stakingDrawerPageState is StakingDrawerPageLoadingState;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerTitle(
              title: S.of(context).stakingPoolDetails,
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.people,
                        color: DesignColors.white2,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stakingDrawerPageState.stakingPoolModel?.totalDelegators.toString() ?? '---',
                        style: textTheme.bodyMedium!.copyWith(
                          color: DesignColors.white2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                StakingStatusChip(stakingPoolStatus: widget.validatorStakingModel.stakingPoolStatus),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 20),
            AccountTileCopyWrapper.fromValidatorSimplifiedModel(validatorSimplifiedModel),
            const SizedBox(height: 20),
            StakingPoolDetailsGrid(
              errorBool: errorBool,
              loadingBool: loadingBool,
              stakingPoolModel: stakingDrawerPageState.stakingPoolModel,
            ),
          ],
        );
      },
    );
  }
}
