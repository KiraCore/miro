import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class StakingListTitleMobile extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const StakingListTitleMobile({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ListSearchWidget<ValidatorStakingModel>(
            textEditingController: searchBarTextEditingController,
            hint: S.of(context).validatorsHintSearch,
          ),
        ),
        const SizedBox(height: 10),
        KiraElevatedButton(
          height: 40,
          title: S.of(context).txButtonClaimAllRewards,
          onPressed: () => KiraRouter.of(context).push(
            const TransactionsWrapperRoute(
              children: <PageRouteInfo>[
                StakingTxClaimRewardsRoute(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
